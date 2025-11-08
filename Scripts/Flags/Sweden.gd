extends CharacterBody2D


@export var speed = 100.0
@export var jump_velocity = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = -speed
	
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		velocity.y = jump_velocity
