extends Sprite2D

var score := [0, 0]# 0:Player, 1: CPU
const PADDLE_SPEED : int = 200
func _on_ball_timer_timeout():
	$Ball.new_ball()

func _on_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	$Hud/cpuscore.text = "CPU: " + str(score[1])
	$BallTimer.start()
func _on_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	$Hud/playerscore.text = "Você: " +str(score[0])
	$BallTimer.start()
func _process(delta: float) -> void:
	if Input.is_action_pressed("close"):
		get_tree().change_scene_to_file("res://Scenes/Controle.tscn")
#		volta pra tela inicial de escolha (só recarrega a cena principal)
