extends Node


signal changed_level(relative: int)


var level := 1
var deaths := 0
var world: Node2D:
	get:
		return get_tree().get_first_node_in_group(&"World")


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
		elif text == "F3":
			reload_level()


func load_level(num: int) -> void:
	var scene: PackedScene = load("res://Scenes/Levels/Level%s.tscn" % num)
	
	if not world and OS.is_debug_build():
		get_tree().change_scene_to_file("res://Scenes/World.tscn")
		await get_tree().create_timer(0.1).timeout
	
	var level_node: Node2D = world.get_node(^"Level")
	
	for child in level_node.get_children():
		child.queue_free()
	
	if not scene:
		get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
		return
	
	level_node.call_deferred(&"add_child", scene.instantiate())


func next_level() -> void:
	level += 1
	load_level(level)
	changed_level.emit(1)


func previous_level() -> void:
	level -= 1
	load_level(level)
	changed_level.emit(-1)


func reload_level() -> void:
	load_level(level)
	changed_level.emit(0)
