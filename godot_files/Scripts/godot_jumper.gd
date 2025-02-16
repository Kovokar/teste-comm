extends Node2D

const obstacles = preload("res://Scenes/obstacles.tscn")


func _ready() -> void:
	pass
func _on_player_hit() -> void:
	$restart.show_gameover()


func _on_spawn_timer_timeout() -> void:
	var obs = obstacles.instantiate()
	self.add_child(obs)
	obs.position = Vector2(705, 396)
