extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_botão_teste_1_pressed() -> void:
	print("mudar cena para teste 1")
	get_tree().change_scene_to_file("res://Scenes/pong.tscn")


func _on_botão_teste_2_pressed() -> void:
	print("mudar cena para teste 2")
	get_tree().change_scene_to_file("res://Scenes/godot_jumper.tscn")


func _on_botão_teste_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
