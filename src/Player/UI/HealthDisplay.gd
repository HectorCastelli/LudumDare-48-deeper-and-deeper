extends HBoxContainer


func _ready() -> void:
	PlayerScores.connect("health_changed", self, "updateUI")
	updateUI(PlayerScores.currentHealth)
	pass # Replace with function body.
	

onready var healthIcons = $"Health Icon"

func updateUI(newHealth):
	var healthTex = healthIcons.texture as AtlasTexture
	healthTex.region = Rect2(newHealth*16, 0, 16, 16)
	pass	
