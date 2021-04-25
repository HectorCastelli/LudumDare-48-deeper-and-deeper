extends StaticBody

func _on_Area_body_entered(body: Node) -> void:
	PlayerScores.add_coin()
	self.queue_free()
	pass # Replace with function body.
