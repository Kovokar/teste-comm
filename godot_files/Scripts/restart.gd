extends CanvasLayer

signal gameover

func show_gameover():
	$gameover.show()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		emit_signal("gameover")
		get_tree().reload_current_scene()
		Global.score = 0
		$gameover.hide()
