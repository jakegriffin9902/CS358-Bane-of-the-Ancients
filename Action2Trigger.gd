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
		can_move = false
		get_node("CanvasLayer/vbox/hbox/no").set_visible(false)
		get_node("CanvasLayer/vbox/hbox/yes").set_visible(false)
		get_node("CanvasLayer/vbox/hbox/ok").set_visible(false)	
		get_node("CanvasLayer").set_visible(true)
		get_node("CanvasLayer/vbox/text").set_text("Your presence has caught the
		attention of a lurking
		alligator.")
		get_parent().get_node("Player").set("can_move", false)
		
		await get_tree().create_timer(4.0).timeout
		
		get_node("CanvasLayer/vbox/text").set_text(
		"It rushes toward you!")
		
		await get_tree().create_timer(3.0).timeout
		
		get_node("CanvasLayer").set_visible(false)
		get_tree().change_scene_to_file("res://scenes/combat.tscn")
