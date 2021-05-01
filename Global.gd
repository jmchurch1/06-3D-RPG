extends Node

var amount = 3
var enemies = 10

func _unhandled_input(_event):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()
