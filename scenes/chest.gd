extends Area2D

@export var activated:bool=false

func _get(property):
	return property
	
func _set_activation():
	activated = true
