extends Area2D

@export var touch_action1 : bool = false
@export var count_touch_action1 : float = 0
@export var can_move: bool

func _on_body_entered(_body):
	Action1Trigger()
	
func Action1Trigger():
	count_touch_action1 += 1
	if count_touch_action1 != 1:
		touch_action1 = true
		print(get_tree())
		can_move = false
		get_node("CanvasLayer").set_visible(true)
		get_node("CanvasLayer/vbox/text").set_text("You spot two wounded creatures nearby.
		Do you wish to help?")
		get_parent().get_node("Player").set("can_move", false)


func _on_yes_pressed():
	# We need to add more text to lead into combat
	get_tree().change_scene_to_file("res://battletest.tscn")


func _on_no_pressed():
	get_node("CanvasLayer/vbox/text").set_text(
		"As you pass the creatures by,
		they succumb to their wounds.")
	get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
	get_node("CanvasLayer/vbox/hbox/ok").set_visible(true)
	


func _on_ok_pressed():
	get_parent().get_node("Player").set("can_move", true)
	get_node("CanvasLayer").set_visible(false)
