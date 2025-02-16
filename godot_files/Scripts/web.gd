extends Node2D

var score = 0
var txt = ""
var client = StreamPeerTCP.new()
var connected: bool = false

const ip = "192.168.1.111"

const port = 80
#variáveis de controle de comandos
var buttonstateA: int;
var buttonstateB: int;
var pulo: int;
signal cima(player)
signal baixo(player)
func _ready():
	
	client.connect_to_host(ip, port)
	if(client.get_status() == 1):
		connected = true
		#print(client.get_status())
		print("conectado à rede Wi-Fi!")
		print("mensagem recebida")
		
func _process(_delta):
	#print(client.get_connected_host())
	#print(client.get_status())
	if connected and not client.get_status() == 1:
		connected = false
		print("nao conectado:(")
	else:
		_readWebSocket()
		
func _readWebSocket():
	while client.get_available_bytes()>0:
		var message = client.get_utf8_string(client.get_available_bytes())
		#print(message)
		if message == null:
			continue
		elif message.length()>0:
			for i in message:
				if i =='\n':
					_messageInterpreter(txt)
					print(txt)
					txt = ''
				else:
					txt += i
func _writeWebsocket(txt):
	if connected and client.get_status() == 1:
		client.put_data(txt.to_ascii())

func _messageInterpreter(txt):		
	var command = txt.split(' ')
	if command.size()<2:
		return
	else:		
		if command[1] == "Aligado":
#			botão A ativado
			buttonstateA = 1
			emit_signal("cima")
		
		if command[1] == "Bligado":
			emit_signal("baixo")
#			botão B ativado
			buttonstateB = 1
			
		if command[1] == "Adesligado":
#   		botão A desativado
			buttonstateA = 0
		if command[1] == "Bdesligado":
			buttonstateB = 0
#   		botão B desativado

		if command[1] == "pulo":
#			se satisfeita essa condição, significa que o valor do barulho está dentro do limite predefinido
			pulo = 1;
			
