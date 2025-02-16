extends StaticBody2D

var win_height : int
var p_height : int

# funções de movimento acionados pelo sinal
func _baixo(delta):
	position.y -= get_parent().PADDLE_SPEED * delta
func _cima(delta):
	position.y += get_parent().PADDLE_SPEED * delta

func _ready():
	#$".".connect("timeout", Callable(self, "randtime"))
	Global.connect("baixo", Callable(self, "_baixo"))
	Global.connect("baixo", Callable(self, "_cima"))
	
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	mudar a linha abaixo para o joystick Y-
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
#   mudar a linha abaixo para o joystick Y+
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta

	#limit paddle movement to window
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
