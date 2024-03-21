extends CharacterBody2D

@export var can_move : bool = true
@export var move_speed : float = 45
@export var starting_direction : Vector2 = Vector2(0,1)

@export var touch_action1 : bool = false
@export var count_touch_action1 : float = 0

@onready var animation_tree = $AnimationTree
@onready var game_text = $CanvasLayer/GameText
@onready var text_rect = $CanvasLayer/ColorRect

var maxHealth=10
var curHealth=10

func _ready():
	animation_tree.set("parameters/Move/blend_position", starting_direction)
	game_text.visible = false
	text_rect.visible = false

func _physics_process(_delta):
	if can_move:
		# Get input direction
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
		update_animation_parameters(input_direction)
	
		# Update velocity
		velocity = input_direction * move_speed
	
		# Move and Slide function uses velocity of character body to move character on map
		move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
		if(move_input != Vector2.ZERO):
			animation_tree.set("parameters/Move/blend_position", move_input)


func _on_action_1_trigger_body_entered(_body):
	count_touch_action1 += 1
	if count_touch_action1 != 1:
		touch_action1 = true
		can_move = false
		game_text.visible = true
		text_rect.visible = true
		game_text.text = "Character entered the trigger area!"


func _on_exit_north_body_entered(_body):
	get_tree().change_scene_to_file("res://fen_2a.tscn")


func _on_exit_south_body_entered(_body):
	get_tree().change_scene_to_file("res://fen_2b.tscn")
