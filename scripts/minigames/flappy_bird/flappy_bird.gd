extends Node2D

var gravity = 1000.0
var jump_strength = -500.0
var is_game_over = false

@onready var bird = $CharacterBody2D 



func _ready():
	add_to_group("Game")
	# Hide the Game Over label at the start
	#game_over_label.visible = false

func _physics_process(delta):
	if is_game_over:
		return

	if not bird.is_on_floor():
		bird.velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):  
		bird.velocity.y = jump_strength

	bird.move_and_slide()
	#i might make the below function work later
	#bird.rotation = lerp_angle(bird.rotation, clamp(bird.velocity.angle(), -PI / 6, PI / 3), 0.01)



func game_over():
	is_game_over = true
