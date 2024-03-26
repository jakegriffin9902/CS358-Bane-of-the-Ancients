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
		get_node("CanvasLayer/background").set_visible(true)
		get_node("CanvasLayer/text").set_visible(true)
		get_node("CanvasLayer/text").set_text("You spot two wounded creatures nearby.
		Do you wish to help?")
		get_parent().get_node("Player").set("can_move", false)
