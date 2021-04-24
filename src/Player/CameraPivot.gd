extends Spatial

export var CAMERA_SENSITIVITY = { "x": 1.2, "y": 1.5 } 

onready var fpsCameraPivot = $Camera

func _ready():
	# Capture mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	# Free mouse if escape is pressed
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Recapture the mouse if a click is capture on the visible window
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Camera movement
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		fpsCameraPivot.rotate_x(deg2rad(event.relative.y * CAMERA_SENSITIVITY.y * -1))
		self.rotate_y(deg2rad(event.relative.x * CAMERA_SENSITIVITY.x * -1))

		var camera_rot = fpsCameraPivot.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		fpsCameraPivot.rotation_degrees = camera_rot
