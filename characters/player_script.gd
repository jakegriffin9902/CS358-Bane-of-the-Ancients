extends CharacterBody2D

@export var can_move : bool = true
@export var move_speed : float = 45
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree

@export var strength = 1
var agility = 1
var intelligence = 1
var aim = 1
var maxHealth = 10
var curHealth = 10

func _ready():
	animation_tree.set("parameters/Move/blend_position", starting_direction)

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


func _on_exit_north_body_entered(_body):
	get_tree().change_scene_to_file("res://scenes/stat_sheet.tscn")


func _on_exit_south_body_entered(_body):
	get_tree().change_scene_to_file("res://fen_2b.tscn")

func _get(property):
	return property
