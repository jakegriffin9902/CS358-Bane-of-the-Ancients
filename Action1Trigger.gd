extends Area2D

@export var touch_action1 : bool = false
@export var count_touch_action1 : float = 0
@export var can_move: bool
var location: Vector2

func _on_body_entered(_body):
	Action1Trigger()
	
func Action1Trigger():
	count_touch_action1 += 1
	if count_touch_action1 != 1 and touch_action1 == false:
		touch_action1 = true
		print(get_tree())
		can_move = false
		get_node("CanvasLayer").set_visible(true)
		get_node("CanvasLayer/vbox/text").set_text("You spot two wounded creatures
		nearby. Do you wish to help?")
		get_parent().get_node("Player").set("can_move", false)

func _on_yes_pressed():
	get_parent().get_node("Player").position = Vector2(180, 160)
	
	get_node("CanvasLayer/vbox/text").set_text("You approach the creatures...")
	get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/ok").set_visible(false)	
	
	await get_tree().create_timer(3.0).timeout
	
	get_node("CanvasLayer/vbox/text").set_text(
		"They suddenly begin choking
		as a vicious disease devours
		them from within.")
	
	await get_tree().create_timer(4.0).timeout
	
	get_parent().get_node("Human carrier/Sprite2D").set_frame(1)
	get_parent().get_node("Animal carrier/Sprite2D").set_frame(1)
	await get_tree().create_timer(0.5).timeout
	
	get_parent().get_node("Human carrier/Sprite2D").set_frame(2)
	get_parent().get_node("Animal carrier/Sprite2D").set_frame(2)
	await get_tree().create_timer(0.5).timeout
	
	get_node("CanvasLayer/vbox/text").set_text(
		"They rush toward you!")
	
	await get_tree().create_timer(3.0).timeout
	
	get_node("CanvasLayer").set_visible(false)
	Global.combat_completed=1
	get_tree().change_scene_to_file("res://scenes/combat.tscn")

func _on_no_pressed():
	get_node("CanvasLayer/vbox/text").set_text(
		"As you pass the creatures by,
		they succumb to their wounds.")
		
	get_node("CanvasLayer/vbox/hbox/ok").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
		
	await get_tree().create_timer(2.0).timeout
	
	get_parent().get_node("Human carrier/Sprite2D").set_frame(1)
	get_parent().get_node("Animal carrier/Sprite2D").set_frame(1)
	await get_tree().create_timer(0.5).timeout
	
	get_parent().get_node("Human carrier/Sprite2D").set_frame(2)
	get_parent().get_node("Animal carrier/Sprite2D").set_frame(2)
	await get_tree().create_timer(0.5).timeout
	
	get_parent().get_node("Human carrier/Sprite2D").set_frame(5)
	get_parent().get_node("Animal carrier/Sprite2D").set_frame(5)
	await get_tree().create_timer(2.0).timeout

	get_node("CanvasLayer/vbox/hbox/ok").set_visible(true)

func _on_ok_pressed():
	get_parent().get_node("Player").set("can_move", true)
	get_node("CanvasLayer").set_visible(false)
