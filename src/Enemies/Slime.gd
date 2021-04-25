extends KinematicBody

export var INDECISION_TIME = 2
export var MOVEMENT_RANGE = 8
export var MOVE_SPEED = 100

var rng = RandomNumberGenerator.new()

onready var decisionTimer = $DecisionTimer

func _ready() -> void:
	decisionTimer.wait_time = INDECISION_TIME
	rng.randomize()
	update_navigation()
	
var navigation:Navigation
func update_navigation():
	navigation = EnemyManager.navigationRef
	
var should_navigate := true
func _on_DecisionTimer_timeout() -> void:
	should_navigate = true
	choose_new_destination()
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if navigation and should_navigate:
		if not navPath.size():
			choose_new_destination()
			return
		if navPathIndex < navPath.size():
			var direction:Vector3 = navPath[navPathIndex] - self.global_transform.origin
			direction.y = 0
			if direction.length_squared() < 1:
				navPathIndex += 1
			else:
				var velocity = direction.normalized() * MOVE_SPEED
				move_and_slide( velocity * delta, Vector3.UP)
		else:
			should_navigate = false
			decisionTimer.start()
	pass

var currentDestination
var navPath := []
var navPathIndex := 0
func choose_new_destination():
	if not navigation:
		print("NO NAVIGATION READY")
		return
	navPath = []
	navPathIndex = 0
	var nav_tries = 0
	while not navPath.size() and nav_tries < 3:
		nav_tries+=1
		var targetPoint := self.global_transform.origin + Vector3(rng.randf_range(-MOVEMENT_RANGE,MOVEMENT_RANGE), 0, rng.randf_range(-MOVEMENT_RANGE,MOVEMENT_RANGE))
		currentDestination = navigation.get_closest_point(targetPoint)
		navPath = navigation.get_simple_path(self.global_transform.origin, currentDestination)
	pass


onready var hitTimer = $Area/HitTimer
onready var hitArea = $Area

func _on_Area_body_entered(body: Node) -> void:
	PlayerScores.remove_health()
	hitTimer.start()
	hitArea.monitoring = false


func _on_HitTimer_timeout() -> void:
	hitArea.monitoring = true
