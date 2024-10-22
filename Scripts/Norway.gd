extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(&"move_left", &"move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i: int in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider: Node = collision.get_collider()
		
		if collider.is_in_group(&"Kill"):
			position = Vector2(80, 608)
		elif collider.is_in_group(&"Finish"):
			Game.next_level()
			position = Vector2(80, 608)
