extends StaticBody2D

var score = 0
var max_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	for key: Key in get_tree().get_nodes_in_group(&"Key"):
		max_score += 1
		
		key.collected.connect(func():
			score += 1
			
			if score >= max_score:
				queue_free()
		)
