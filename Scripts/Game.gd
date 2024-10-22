extends Node


var level := 1
var world: Node2D:
	get:
		return get_tree().get_first_node_in_group(&"World")
var load_level_timer: SceneTreeTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_released():
		return
	
	var text = event.as_text()
	
	if text == "Escape":
		get_tree().quit()
	
	if OS.is_debug_build():
		if text == "F1":
			previous_level()
		elif text == "F2":
			next_level()


func load_level(num: int) -> void:
	if load_level_timer && load_level_timer.time_left > 0:
		return
	
	var scene: PackedScene = load("res://Scenes/Levels/Level%s.tscn" % num)
	var level_node: Node2D = world.get_node(^"Level")
	
	for child in level_node.get_children():
		child.queue_free()
	
	if not scene:
		# TODO: Show end-screen
		return
	
	level_node.add_child(scene.instantiate())
	
	load_level_timer = get_tree().create_timer(0.1)


func next_level() -> void:
	level += 1
	load_level(level)


func previous_level() -> void:
	level -= 1
	load_level(level)
