extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



var speed = 200 

func _process(delta):
	position.x -= speed * delta

	if position.x < -350:
		queue_free() 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		scene_switcher.switch_scene("res://scenes/minigames/gameOverMini.tscn")
