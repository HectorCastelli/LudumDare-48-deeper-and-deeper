extends Spatial

onready var light = $SpotLight
onready var animatedSprite = $AnimatedSprite3D

export var LIGHT_ENERGY = 8.0

var is_light_on = false

func _ready():
	light.light_energy = 0
	animatedSprite.play("off")

func _input(event):
	# Free mouse if escape is pressed
	if event.is_action_pressed("use_light"):
		is_light_on = !is_light_on
		if is_light_on:
			light.light_energy = LIGHT_ENERGY
			animatedSprite.play("on")
		else:
			light.light_energy = 0
			animatedSprite.play("off")
