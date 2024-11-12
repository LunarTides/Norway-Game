extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.level_changed.connect(_on_level_change)
	Game.died.connect(update_death_counter)
	
	# When debugging, escaping from the win screen would reset the death label unless I do this.
	update_death_counter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_change(relative: int, level: Level) -> void:
	if not level:
		return
	
	%LevelNameLabel.text = "%s - %s" % [Game.level, level.level_name]


func update_death_counter() -> void:
	%DeathsLabel.text = "Deaths: %s" % Game.deaths
