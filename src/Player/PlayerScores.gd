extends Node

var currentCoins := 0
var currentHealth := 3

var analytics_jumps := 0

func add_coin():
	currentCoins+=1
	
func remove_health():
	currentHealth-=1
	
func analytics_jump():
	analytics_jumps+=1
