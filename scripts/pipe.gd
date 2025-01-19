extends Area2D

func _ready():
	add_to_group("pipes")

var speed = 200 

func _process(delta):
	position.x -= speed * delta

	if position.x < -350:
		queue_free() 


func _on_body_entered(body: Node2D) -> void:
	# Add your code for the gameover state here
	if body.name == "CharacterBody2D":
		scene_switcher.switch_scene("res://scenes/gameOverMini.tscn")
