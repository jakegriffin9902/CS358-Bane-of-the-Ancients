extends Control

@onready var available_points = get_node("stats/points/value")

var player_points = 5
var strength_add = 0
var intelligence_add = 0
var aim_add = 0
var agility_add = 0
var health_add = 0

func _ready():
	available_points.set_text("[color=black]" + str(player_points))
	if (player_points == 0):
		pass
	else:
		for button in get_tree().get_nodes_in_group("plus"):
			button.set_disabled(false)
