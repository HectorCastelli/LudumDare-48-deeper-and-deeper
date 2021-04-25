extends Control

onready var mainMenu = $VBoxContainer
onready var about = $AboutContainer
onready var controls = $ControlsContainer


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		about.hide()
		controls.hide()

func _on_About_pressed() -> void:
	about.show()


func _on_StartGame_pressed() -> void:
	get_tree().change_scene("res://src/TestScene.tscn")


func _on_Controls_pressed() -> void:
		controls.show()
