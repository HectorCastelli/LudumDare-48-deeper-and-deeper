extends Node

signal navigation_loaded

var navigationRef

func registerNavigation(nav:Navigation):
	navigationRef = nav
	emit_signal("navigation_loaded", nav)
