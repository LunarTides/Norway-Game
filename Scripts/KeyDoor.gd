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
			update_score_label()
			
			if score >= max_score:
				$CollisionShape2D.set_deferred(&"disabled", true)
				modulate = Color.hex(0x93939393)
		)
	
	update_score_label()


func update_score_label() -> void:
	%Count.text = "%s / %s" % [score, max_score]
