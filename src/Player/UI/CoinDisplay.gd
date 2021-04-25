extends HBoxContainer


func _ready() -> void:
	PlayerScores.connect("coins_changed", self, "updateUI")
	updateUI(PlayerScores.currentCoins)
	pass # Replace with function body.
	
onready var coinCount = $"Coin Count"

func updateUI(newCoinCount):
	coinCount.text = newCoinCount as String
	pass	
