extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var health = 1

signal hit

func Player_hit():
	emit_signal("hit")
	health -= 1
	if health == 0:
		queue_free()
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

#	mudar para os valores do microfone
	if (Input.is_action_just_pressed("jump")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
