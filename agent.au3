Local $agent_IP="127.0.0.1"
TCPStartup();��ʼTCP����
Local $socket=TCPConnect($agent_IP,12315)
If $socket= -1 Then Exit
While 1
	$senddata=InputBox("�������ݵ���������",@LF & @LF & "����Ҫ���͵�����:")
	If $senddata="" Then Exit
	TCPSend($socket,StringToBinary($senddata,4))
	If @error Then  ExitLoop
WEnd