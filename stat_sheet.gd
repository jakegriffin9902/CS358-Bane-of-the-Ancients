extends Control

@onready var available_points = get_node("stats/points/value")
@onready var strength = get_node("stats/strength/value")
@onready var intelligence = get_node("stats/intelligence/value")
@onready var agility = get_node("stats/agility/value")
@onready var health = get_node("stats/health/value")
@onready var aim = get_node("stats/aim/value")
@onready var player = get_node("player")

var player_points = 5
var strength_add = 0
var intelligence_add = 0
var aim_add = 0
var agility_add = 0
var health_add = 0

var format = "[color=black]"

func _ready():
	available_points.set_text(format + str(player_points))
	strength.set_text(format + str(player.get("strength")))
	agility.set_text(format + str(player.get("agility")))
	intelligence.set_text(format + str(player.get("intelligence")))
	aim.set_text(format + str(player.get("aim")))
	health.set_text(format + str(player.get("maxHealth")))

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
	player.set("strength", player.get("strength") + strength_add)
	player.set("agility", player.get("agility") + agility_add)
	player.set("intelligence", player.get("intelligence") + intelligence_add)
	player.set("aim", player.get("aim") + aim_add)
	player.set("maxHealth", player.get("maxHealth") + health_add)
	get_tree().change_scene_to_file("res://scenes/fen_2a.tscn")

func update_confirm():
	if (player_points > 0):
		get_node("stats/confirm").set_disabled(true)
	else:
		get_node("stats/confirm").set_disabled(false)

func decrease_available_points():
	player_points -= 1
	available_points.set_text(format + str(player_points))
	update_plus_restriction(player_points)
	update_confirm()

func increase_available_points():
	player_points += 1
	available_points.set_text(format + str(player_points))
	update_plus_restriction(player_points)
	update_confirm()

func strength_minus():
	strength_add -= 1
	strength.set_text(format + str(strength_add + player.get("strength")))
	increase_available_points()
	update_minus_restriction(get_node("stats/strength/minus"), strength_add)

func strength_plus():
	strength_add += 1
	strength.set_text(format + str(strength_add + player.get("strength")))
	decrease_available_points()
	update_minus_restriction(get_node("stats/strength/minus"), strength_add)

func intelligence_minus():
	intelligence_add -= 1
	intelligence.set_text(format + str(intelligence_add + player.get("intelligence")))
	increase_available_points()
	update_minus_restriction(get_node("stats/intelligence/minus"), intelligence_add)

func intelligence_plus():
	intelligence_add += 1
	intelligence.set_text(format + str(intelligence_add + player.get("intelligence")))
	decrease_available_points()
	update_minus_restriction(get_node("stats/intelligence/minus"), intelligence_add)

func aim_minus():
	aim_add -= 1
	aim.set_text(format + str(aim_add + player.get("aim")))
	increase_available_points()
	update_minus_restriction(get_node("stats/aim/minus"), aim_add)

func aim_plus():
	aim_add += 1
	aim.set_text(format + str(aim_add + player.get("aim")))
	decrease_available_points()
	update_minus_restriction(get_node("stats/aim/minus"), aim_add)

func agility_minus():
	agility_add -= 1
	agility.set_text(format + str(agility_add + player.get("agility")))
	increase_available_points()
	update_minus_restriction(get_node("stats/agility/minus"), agility_add)

func agility_plus():
	agility_add += 1
	agility.set_text(format + str(agility_add + player.get("agility")))
	decrease_available_points()
	update_minus_restriction(get_node("stats/agility/minus"), agility_add)

func health_minus():
	health_add -= 1
	health.set_text(format + str(health_add + player.get("maxHealth")))
	increase_available_points()
	update_minus_restriction(get_node("stats/health/minus"), health_add)

func health_plus():
	health_add += 1
	health.set_text(format + str(health_add + player.get("maxHealth")))
	decrease_available_points()
	update_minus_restriction(get_node("stats/health/minus"), health_add)
