extends Node2D

func update_stats(strength, intelligence, aim, agility, health):
	get_node("Player").strength = strength
	get_node("Player").intelligence = intelligence
	get_node("Player").aim = aim
	get_node("Player").agility = agility
	get_node("Player").maxHealth = health
	get_node("Player").curHealth = health
