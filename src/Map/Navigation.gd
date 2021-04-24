extends Navigation

func _ready() -> void:
	EnemyManager.registerNavigation(self)
