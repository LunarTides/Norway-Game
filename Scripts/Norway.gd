class_name Player
extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis(&"move_left", &"move_right")
	velocity.x = direction * speed

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"Kill"):
		global_position = Vector2(80, 608)
		await get_tree().process_frame
		global_position = Vector2(80, 608)
		Game.reload_level()
	elif body.is_in_group(&"Finish"):
		global_position = Vector2(80, 608)
		await get_tree().process_frame
		global_position = Vector2(80, 608)
		Game.next_level()
