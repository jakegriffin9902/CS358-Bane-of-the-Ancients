extends Control

signal textbox_closed

@export var enemy:Resource=null

var current_player_health=0
var current_enemy_health=0
var isdefending=false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_health($EnemyContainer/ProgressBar, enemy.health,enemy.health)
	set_health($PlayerPanel/HBoxContainer/ProgressBar, PlayerScript.curHealth,PlayerScript.maxHealth)
	$EnemyContainer/Enemy.texture=enemy.texture
	$Textbox.hide()
	$Actions.hide()
	display_text("The pair attack!")
	current_player_health=PlayerScript.curHealth
	current_enemy_health=enemy.health
	await textbox_closed
	$Actions.show()
func set_health(progress_bar,health,max_health):
	progress_bar.value=health
	progress_bar.max_value=max_health
	progress_bar.get_node("Label").text="HP:%d/%d"%[health,max_health]
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text =text
	
func enemy_turn():
	display_text("The zombies bite at you!")
	await textbox_closed
	if(isdefending):
		display_text("You block the attack!")
		await textbox_closed
		current_player_health-=1
	else:
		current_player_health=max(0,current_player_health-enemy.damage)

	set_health($PlayerPanel/HBoxContainer/ProgressBar,current_player_health,PlayerScript.maxHealth)



func _on_attack_pressed():
	display_text("You swing your sword!")
	await textbox_closed
	current_enemy_health=max(0,current_enemy_health-3)
	set_health($EnemyContainer/ProgressBar,current_enemy_health,enemy.health)
	$AnimationPlayer.play("enemy_hit")
	await "animation_finished"
	enemy_turn()


func _on_defend_pressed():
	isdefending=1
	enemy_turn()

