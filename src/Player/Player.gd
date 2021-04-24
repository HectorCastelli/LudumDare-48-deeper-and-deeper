extends KinematicBody

export var GRAVITY = Vector3.DOWN * 25
export var MOVEMENT_SPEED = 5
export var JUMP_POWER = 12

onready var animatedSprite  = $AnimatedSprite3D
onready var cameraPivot = $CameraPivot

var velocity = Vector3()
var try_jump = false

func get_input():
	handle_movement()
	handle_jump()
	
func handle_movement():
	var vy = velocity.y
	velocity = Vector3()
	var newVelocity = Vector3()
	if Input.is_action_pressed("move_forward"):
		newVelocity += -cameraPivot.transform.basis.z
	if Input.is_action_pressed("move_back"):
		newVelocity += cameraPivot.transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		newVelocity += -cameraPivot.transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		newVelocity += cameraPivot.transform.basis.x
	velocity += newVelocity.normalized() * MOVEMENT_SPEED
	velocity.y = vy
	
func handle_jump():
	try_jump = false
	if Input.is_action_just_pressed("jump"):
		try_jump = true

func _physics_process(delta):
	velocity += GRAVITY * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if try_jump and is_on_floor():
		PlayerScores.analytics_jump()
		velocity.y = JUMP_POWER
	handle_animation()

func handle_animation():
	if not is_on_floor():
		animatedSprite.play("flail")
	else:
		if abs(velocity.x)>0 or abs(velocity.y)>0:
			animatedSprite.play("walk")
		elif is_on_floor():
			animatedSprite.play("idle")
		
