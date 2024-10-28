extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%DeathLabel.text = "Deaths: %d" % Game.deaths
