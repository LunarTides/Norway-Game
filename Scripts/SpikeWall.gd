extends StaticBody2D


@export var speed = 10
@export var offset = 32


func _ready() -> void:
	position.x -= offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
