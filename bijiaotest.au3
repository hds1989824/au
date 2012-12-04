;$good = huihui("联想（Lenovo）乐Pad A2107")
$good1=InputBox("输入商品名称","请输入一个商品名称")
$good =huihui($good1)
$bijia = ""
For $o = 0 To UBound($good) - 1
        If Mod($o, 2) = 0 Then
                $bijia = $good[$o][0] & "          " & $good[$o][1] & @CR & $bijia
        Else
                $bijia = $good[$o][0] & "        " & $good[$o][1] & " | " & $bijia
        EndIf
Next
MsgBox(0, "", $bijia)

Func huihui($string)
        $ursd = "http://www.huihui.cn/search?q=" & $string
        $oHTTP = ObjCreate("MSXML2.XMLHTTP")
        $oHTTP.Open("get", $ursd, False)
        $oHTTP.setRequestHeader("Cache-Control", "no-cache")
        $oHTTP.setRequestHeader("Accept-Language", "zh-cn")
        $oHTTP.setRequestHeader("Accept-Encoding", "gzip, deflate")
        $oHTTP.setRequestHeader("x-requested-with", "XMLHttpRequest")
        $oHTTP.Send("")
        $a = ($oHTTP.responsetext)
        
        $shop = StringRegExp($a, '<(?s)div class="sc-shop-logo">(.*?)</(?s)div>', 3)
        $pay = StringRegExp($a, '<em class.*?>(.*?)</em><span>元', 3)
        If @error = 0 Then
                Local $price[UBound($shop) - 1][2]
                For $i = 0 To UBound($shop) - 2
                        $shopname = StringStripWS(StringStripCR($shop[$i]), 8)
                        $price[$i][0] = $shopname
                        $price[$i][1] = $pay[$i]
                Next
                Return $price
        Else
                Return 0
        EndIf
EndFunc   ;==>huihui