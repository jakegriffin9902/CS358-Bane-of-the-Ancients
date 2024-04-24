extends Control

signal textbox_closed

var current_player_health=0
var current_enemy_health=0
var isdefending=false
@onready var enemy = get_node("zombie")
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.level==2):
		enemy=get_node("gator")
	set_health($EnemyContainer/ProgressBar, enemy.health,enemy.health)
	set_health($PlayerPanel/HBoxContainer/ProgressBar, PlayerStats.curHealth, PlayerStats.maxHealth)
	$EnemyContainer/Enemy.texture=enemy.texture
	$Textbox.hide()
	$Actions.hide()
	if(Global.level==1):
		display_text("The pair attack!")
	else:
		display_text("The Gator charges!")
	current_player_health=PlayerStats.curHealth
	current_enemy_health=enemy.health
	await textbox_closed
	if(enemy.agility>PlayerStats.agility):
		enemy_turn()
	$Actions.show()

func set_health(progress_bar,health,max_health):
	progress_bar.value=health
	progress_bar.max_value=max_health
	progress_bar.get_node("Label").text="HP:%d/%d"%[health,max_health]

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text =text

func enemy_turn():
	if(Global.level==1):
		display_text("The zombies bite at you!")
	else:
		display_text("The Gator snaps at you!")
	await textbox_closed
	if(isdefending):
		display_text("You block the attack!")
		await textbox_closed
		current_player_health-=1
		isdefending=false
	else:
		current_player_health=max(0,current_player_health-int(rng.randf_range(1, enemy.damage)))
	set_health($PlayerPanel/HBoxContainer/ProgressBar,current_player_health,PlayerStats.maxHealth)
	if(current_player_health<=0):
			display_text("You die...")
			await textbox_closed
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_attack_pressed():
	display_text("You swing your sword!")
	await textbox_closed
	current_enemy_health=max(0,current_enemy_health-(get_node("player").strength+int(rng.randf_range(0, 4))))
	set_health($EnemyContainer/ProgressBar,current_enemy_health,enemy.health)
	$AnimationPlayer.play("enemy_hit")
	if(current_player_health<=0):
		display_text("You die...")
		await textbox_closed
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	elif(current_enemy_health<=0):
		Global.healthChange=current_player_health
		display_text("You Win!")
		await textbox_closed
		if(Global.level==1):
			get_tree().change_scene_to_file("res://scenes/fen_1.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/end.tscn")
	enemy_turn()


func _on_defend_pressed():
	isdefending=true
	enemy_turn()

