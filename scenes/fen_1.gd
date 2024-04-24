extends Node2D


func _ready():
	Global.level=1
	print(Global.combat_completed)
	if(Global.combat_completed==1):
		PlayerStats.curHealth=Global.healthChange
		print(PlayerStats.curHealth)
		Global.combat_completed=0
		get_node("Player").position = Vector2(180, 160)
