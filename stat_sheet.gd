extends Control

@onready var available_points = get_node("stats/points/value")
@onready var strength = get_node("stats/strength/value")
@onready var intelligence = get_node("stats/intelligence/value")
@onready var agility = get_node("stats/agility/value")
@onready var health = get_node("stats/health/value")
@onready var aim = get_node("stats/aim/value")

var player_points = 5
var strength_add = 0
var intelligence_add = 0
var aim_add = 0
var agility_add = 0
var health_add = 0

func _ready():
	available_points.set_text(str(player_points))
	strength.set_text(str(PlayerStats.strength))
	agility.set_text(str(PlayerStats.agility))
	intelligence.set_text(str(PlayerStats.intelligence))
	aim.set_text(str(PlayerStats.aim))
	health.set_text(str(PlayerStats.maxHealth))

# Enables all plus buttons if there are ponts to spend, and disables otherwise
func update_plus_restriction(points):
	if points > 0:
		for button in get_tree().get_nodes_in_group("plus"):
			button.set_disabled(false)
	else: # no points to spend
		for button in get_tree().get_nodes_in_group("plus"):
			button.set_disabled(true)

# disables a minus button if the stat is currently at its original level
func update_minus_restriction(button, stat_add):
	if stat_add < 1:
		button.set_disabled(true)
	else:
		button.set_disabled(false)

func _on_confirm_pressed():
	PlayerStats.strength += strength_add
	PlayerStats.agility += agility_add
	PlayerStats.intelligence += intelligence_add
	PlayerStats.aim += aim_add
	PlayerStats.maxHealth += health_add
	PlayerStats.curHealth += health_add
	get_tree().change_scene_to_file("res://scenes/fen_2a.tscn")

func decrease_available_points():
	player_points -= 1
	available_points.set_text(str(player_points))
	update_plus_restriction(player_points)
	update_confirm()

func increase_available_points():
	player_points += 1
	available_points.set_text(str(player_points))
	update_plus_restriction(player_points)
	update_confirm()

func update_confirm():
	if (player_points > 0):
		get_node("stats/confirm").set_disabled(true)
	else:
		get_node("stats/confirm").set_disabled(false)

func strength_minus():
	strength_add -= 1
	strength.set_text(str(strength_add + PlayerStats.strength))
	increase_available_points()
	update_minus_restriction(get_node("stats/strength/minus"), strength_add)

func strength_plus():
	strength_add += 1
	strength.set_text(str(strength_add + PlayerStats.strength))
	decrease_available_points()
	update_minus_restriction(get_node("stats/strength/minus"), strength_add)

func intelligence_minus():
	intelligence_add -= 1
	intelligence.set_text(str(intelligence_add + PlayerStats.intelligence))
	increase_available_points()
	update_minus_restriction(get_node("stats/intelligence/minus"), intelligence_add)

func intelligence_plus():
	intelligence_add += 1
	intelligence.set_text(str(intelligence_add + PlayerStats.intelligence))
	decrease_available_points()
	update_minus_restriction(get_node("stats/intelligence/minus"), intelligence_add)

func aim_minus():
	aim_add -= 1
	aim.set_text(str(aim_add + PlayerStats.aim))
	increase_available_points()
	update_minus_restriction(get_node("stats/aim/minus"), aim_add)

func aim_plus():
	aim_add += 1
	aim.set_text(str(aim_add + PlayerStats.aim))
	decrease_available_points()
	update_minus_restriction(get_node("stats/aim/minus"), aim_add)

func agility_minus():
	agility_add -= 1
	agility.set_text(str(agility_add + PlayerStats.agility))
	increase_available_points()
	update_minus_restriction(get_node("stats/agility/minus"), agility_add)

func agility_plus():
	agility_add += 1
	agility.set_text(str(agility_add + PlayerStats.agility))
	decrease_available_points()
	update_minus_restriction(get_node("stats/agility/minus"), agility_add)

func health_minus():
	health_add -= 1
	health.set_text(str(health_add + PlayerStats.maxHealth))
	increase_available_points()
	update_minus_restriction(get_node("stats/health/minus"), health_add)

func health_plus():
	health_add += 1
	health.set_text(str(health_add + PlayerStats.maxHealth))
	decrease_available_points()
	update_minus_restriction(get_node("stats/health/minus"), health_add)
