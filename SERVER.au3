Local $server="127.0.0.1"
TCPStartup();����TCP����

Local $mainsocket=TCPListen($server,12315,100)
If $mainsocket=-1 Then Exit

While 1 
	$connectedsocket=TCPAccept($mainsocket)
	If $connectedsocket >=0 Then
		MsgBox(0,"","�Ѿ�����")
		$recivedata=TCPRecv($connectedsocket,100)
		MsgBox(0,"",$recivedata)
		Exit
	EndIf
WEnd  