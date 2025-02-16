extends Area2D

@onready var speed = get_parent().get_node("background").backspeed


func _process(delta):
	position += Vector2.LEFT * speed * delta
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player_hit"):
		body.Player_hit()
