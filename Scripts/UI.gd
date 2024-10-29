extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.level_changed.connect(_on_level_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_change(relative: int, level: Level) -> void:
	if not level:
		return
	
	%LevelNameLabel.text = level.level_name
