extends Area2D

@export var touch_action1 : bool = false
@export var count_touch_action1 : float = 0
@export var can_move: bool

@onready var game_text = $CanvasLayer/GameText
@onready var text_rect = $CanvasLayer/ColorRect

func _on_body_entered(body):
	Action1Trigger()
	
func Action1Trigger():
	count_touch_action1 += 1
	if count_touch_action1 != 1:
		touch_action1 = true
		print(get_node().name)
		can_move = false
		game_text.visible = true
		text_rect.visible = true
		game_text.text = "Character entered the trigger area!"
