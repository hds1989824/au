Local $agent_IP="127.0.0.1"
TCPStartup();开始TCP服务
Local $socket=TCPConnect($agent_IP,12315)
If $socket= -1 Then Exit
While 1
	$senddata=InputBox("发送数据到服务器端",@LF & @LF & "输入要发送的数据:")
	If $senddata="" Then Exit
	TCPSend($socket,StringToBinary($senddata,4))
	If @error Then  ExitLoop
WEnd