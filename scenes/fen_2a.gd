extends Node2D

func _ready():
	Global.level=2
	if(Global.combat_completed==1):
		PlayerStats.curHealth=Global.healthChange
		get_node("Player").position = Vector2(300, 100)
func update_stats(strength, intelligence, aim, agility, health):
	get_node("Player").strength = strength
	get_node("Player").intelligence = intelligence
	get_node("Player").aim = aim
	get_node("Player").agility = agility
	get_node("Player").maxHealth = health
	get_node("Player").curHealth = health


func _on_exit_2_entered(_body):
	get_tree().change_scene_to_file("res://scenes/end.tscn")
