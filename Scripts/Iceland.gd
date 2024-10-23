extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = -SPEED
	
	move_and_slide()
	
	if is_on_wall():
		velocity.y = JUMP_VELOCITY
