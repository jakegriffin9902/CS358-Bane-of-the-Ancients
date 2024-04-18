extends Area2D

@export var touch_action2 : bool = false
@export var count_touch_action2 : float = 0
@export var can_move: bool

func _on_body_entered(_body):
	Action2Trigger()
	
func Action2Trigger():
	count_touch_action2 += 1
	if count_touch_action2 != 1 and touch_action2 == false:
		touch_action2 = true
		print(get_tree())
		can_move = false
		# to fix
		get_node("CanvasLayer").set_visible(true)
		get_node("CanvasLayer/vbox/text").set_text("sample text")
		get_parent().get_node("Player").set("can_move", false)

func _on_yes_pressed():
	get_parent().get_node("Player").position = Vector2(180, 160)
	
	get_node("CanvasLayer/vbox/text").set_text("You approach the creatures.")
	get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/ok").set_visible(false)	
	
	await get_tree().create_timer(3.0).timeout
	
	get_node("CanvasLayer/vbox/text").set_text(
		"They begin to succumb
		to their wounds and turn
		aggressive.")
	
	get_node("CanvasLayer").set_visible(false)
	get_tree().change_scene_to_file("res://scenes/combat.tscn")

func _on_no_pressed():
	get_node("CanvasLayer/vbox/text").set_text(
		"As you pass the creatures by,
		they succumb to their wounds.")
		
	get_node("CanvasLayer/vbox/hbox/ok").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
		
	await get_tree().create_timer(2.0).timeout

	get_node("CanvasLayer/vbox/hbox/ok").set_visible(true)

func _on_ok_pressed():
	get_parent().get_node("Player").set("can_move", true)
	get_node("CanvasLayer").set_visible(false)