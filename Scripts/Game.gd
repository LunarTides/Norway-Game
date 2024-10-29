extends Node


signal level_changed(relative: int, level: Level)


var level := 1
var deaths := 0
var world: Node2D:
	get:
		return get_tree().get_first_node_in_group(&"World")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Wait for signal hooks before continuing.
	await get_tree().process_frame
	
	# Loads level 1
	reload_level()


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
		elif text == "F3":
			reload_level()


func load_level(num: int) -> Level:
	var scene: PackedScene = load("res://Scenes/Levels/Level%s.tscn" % num)
	
	if not world and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/World.tscn")
		await get_tree().create_timer(0.1).timeout
	
	var level_root: Node2D = world.get_node(^"Level")
	
	for child in level_root.get_children():
		child.queue_free()
	
	if not scene:
		get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
		return
	
	var level_node: Level = scene.instantiate()
	level_root.call_deferred(&"add_child", level_node)
	
	return level_node


func next_level() -> void:
	level += 1
	var level_node := await load_level(level)
	level_changed.emit(1, level_node)


func previous_level() -> void:
	level -= 1
	var level_node := await load_level(level)
	level_changed.emit(-1, level_node)


func reload_level() -> void:
	var level_node := await load_level(level)
	level_changed.emit(0, level_node)
