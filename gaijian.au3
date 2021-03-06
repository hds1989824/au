#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <WindowsConstants.au3>
#include <StructureConstants.au3>
#include <WinAPI.au3>
Opt('MustDeclareVars', 1)
Global $hHook, $hStub_KeyProc, $buffer = ""
_Main()
Func _Main()
    OnAutoItExitRegister("Cleanup")
    Local $hmod

    $hStub_KeyProc = DllCallbackRegister("_KeyProc", "long", "int;wparam;lparam")
    $hmod = _WinAPI_GetModuleHandle(0)
    $hHook = _WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL, DllCallbackGetPtr($hStub_KeyProc), $hmod)

    MsgBox(4096, "", "单击确定，然后在记事本中输入..." & _
            @LF & @LF & "Jon" & @LF & "AutoIt" & @LF & @LF & "按 'Esc' 退出脚本")
         
            
    Run("Notepad")
    WinWait("Untitled -")
    WinActivate("Untitled -")
            
    While 1
        Sleep(10)
    WEnd
EndFunc ;==>_Main            
Func EvaluateKey($keycode)
    If (($keycode > 64) And ($keycode < 91)) _ ; a - z
            Or (($keycode > 96) And ($keycode < 123)) _ ; A - Z
            Or (($keycode > 47) And ($keycode < 58)) Then ; 0 - 9
       $buffer &= Chr($keycode)
       Switch $buffer
            Case "Jon"
                ToolTip("你能说什么?")
            Case "AutoIt"
                ToolTip("震惊的 AutoIT")
       EndSwitch
    ElseIf ($keycode > 159) And ($keycode < 164) Then
       Return
    ElseIf ($keycode = 27) Then ; esc key
       Exit     
    Else
       $buffer = ""
    EndIf       
EndFunc ;==>EvaluateKey
; ===========================================================
; 回调函数
; ===========================================================
Func _KeyProc($nCode, $wParam, $lParam)
    Local $tKEYHOOKS
    $tKEYHOOKS = DllStructCreate($tagKBDLLHOOKSTRUCT, $lParam)
    If $nCode < 0 Then
        Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)
    EndIf
    If $wParam = $WM_KEYDOWN Then
        EvaluateKey(DllStructGetData($tKEYHOOKS, "vkCode"))
    Else
        Local $flags = DllStructGetData($tKEYHOOKS, "flags")
        Switch $flags
            Case $LLKHF_ALTDOWN
                ConsoleWrite("$LLKHF_ALTDOWN" & @CRLF)
            Case $LLKHF_EXTENDED
                ConsoleWrite("$LLKHF_EXTENDED" & @CRLF)
            Case $LLKHF_INJECTED
                ConsoleWrite("$LLKHF_INJECTED" & @CRLF)
            Case $LLKHF_UP
                ConsoleWrite("$LLKHF_UP: scanCode - " & DllStructGetData($tKEYHOOKS, "scanCode") & @TAB & "vkCode - " & DllStructGetData($tKEYHOOKS, "vkCode") & @CRLF)
        EndSwitch
    EndIf
    Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)
EndFunc   ;==>_KeyProc
Func Cleanup()
    _WinAPI_UnhookWindowsHookEx($hHook)
    DllCallbackFree($hStub_KeyProc)
EndFunc   ;==>Cleanup
