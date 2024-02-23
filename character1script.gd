extends CharacterBody2D

@export var move_speed : float = 45
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree



var agility=1
var strength=1
var constitution=1
var aim=1
var health=1
var maxHealth=9+health
var curHealth=10
func _ready():
	animation_tree.set("parameters/Move/blend_position", starting_direction)

func _physics_process(_delta):
	updateHeart()
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
			
func updateHeart():
	get_node("CanvasLayer/HeartUI").value=curHealth
	if (curHealth>=10):
		get_node("CanvasLayer/HeartUI/HeartUIText").text=str(curHealth)
	else :
		get_node("CanvasLayer/HeartUI/HeartUIText2").text=str(curHealth)
