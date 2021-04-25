extends StaticBody

func _on_Area_body_entered(body: Node) -> void:
	PlayerScores.remove_health()
	PlayerScores.remove_health()
	PlayerScores.remove_health()
