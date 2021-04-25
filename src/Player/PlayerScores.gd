extends Node

var currentCoins := 0
var currentHealth := 3

var analytics_jumps := 0

signal coins_changed
func add_coin():
	currentCoins+=1
	emit_signal("coins_changed", currentCoins)
	
	
signal health_changed
func remove_health():
	currentHealth-=1
	emit_signal("health_changed", currentHealth)
	if currentHealth == 0:
		print("dead")
		get_tree().change_scene("res://src/MainMenu.tscn")
	
func analytics_jump():
	analytics_jumps+=1
