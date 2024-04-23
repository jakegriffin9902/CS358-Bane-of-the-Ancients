extends CharacterBody2D

@export var can_move : bool = true
@export var move_speed : float = 45
@export var starting_direction : Vector2 = Vector2(0,1)
@export var treasures_collected : Array = [false]

@onready var animation_tree = $AnimationTree

@export var strength = 1
var agility = 0
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


func _on_exit_entered(_body):
	get_tree().change_scene_to_file("res://scenes/stat_sheet.tscn")

func _get(property):
	return property


func _on_chest_body_entered(_body):
	if not treasures_collected[0]:
		if PlayerStats.intelligence > 1:
			get_parent().get_node("Player").set("can_move", false)
			
			get_parent().get_node("Chest_CanvasLayer").set_visible(true)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/no").set_visible(false)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/yes").set_visible(false)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/ok").set_visible(false)	
			get_parent().get_node("Chest_CanvasLayer/vbox/text").set_text("You figure out how
			to pick the lock.")
			await get_tree().create_timer(3.0).timeout
			
			get_parent().get_node("Chest_CanvasLayer/vbox/text").set_text("You find a
			health boost inside!")
			PlayerStats.curHealth += 2 * PlayerStats.intelligence
			treasures_collected[0] = true
			get_parent().get_node("Chest/Sprite2D").set_frame(1)
			await get_tree().create_timer(3.0).timeout
			
			get_parent().get_node("Chest_CanvasLayer").set_visible(false)
			get_parent().get_node("Player").set("can_move", true)
		else:
			get_parent().get_node("Chest_CanvasLayer").set_visible(true)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/no").set_visible(false)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/yes").set_visible(false)
			get_parent().get_node("Chest_CanvasLayer/vbox/hbox/ok").set_visible(false)	
			get_parent().get_node("Player").set("can_move", false)
			treasures_collected[0] = true
			
			get_parent().get_node("Chest_CanvasLayer/vbox/text").set_text("The chest is locked.")
			await get_tree().create_timer(3.0).timeout
			
			get_parent().get_node("Chest_CanvasLayer").set_visible(false)
			get_parent().get_node("Player").set("can_move", true)
