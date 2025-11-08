class_name Player
extends CharacterBody2D


@export var speed := 300.0
@export var jump_velocity := -400.0
var is_invincible := false
var can_cayote_jump := false
var was_on_floor_last_frame := false


func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	
	# Add the gravity.
	if not on_floor:
		velocity += get_gravity() * delta
		
		if was_on_floor_last_frame:
			can_cayote_jump = true
		
		was_on_floor_last_frame = false
	else:
		was_on_floor_last_frame = true

	# Handle jump.
	if Input.is_action_pressed(&"jump") and (on_floor or can_cayote_jump):
		velocity.y = jump_velocity
		can_cayote_jump = false

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis(&"move_left", &"move_right")
	velocity.x = direction * speed

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"Kill"):
		if is_invincible:
			return
		
		is_invincible = true
		%InvincibilityTimer.start()
		
		global_position = Vector2(80, 608)
		await get_tree().process_frame
		global_position = Vector2(80, 608)
		Game.deaths += 1
		Game.reload_level()
	elif body.is_in_group(&"Finish"):
		global_position = Vector2(80, 608)
		await get_tree().process_frame
		global_position = Vector2(80, 608)
		Game.next_level()


func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
