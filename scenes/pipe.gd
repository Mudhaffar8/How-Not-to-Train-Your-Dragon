extends Area2D

var onBodyEntered = func(body):
	if body.name == "Bird":  # Check if the body is the bird
		print("Bird collided with pipe!")
		# Trigger your game over or collision logic here
		get_tree().call_group("Game", "game_over")  # Call the game_over function in the main scene
		
func _ready():
	add_to_group("pipes")


var speed = 200 

func _process(delta):

	position.x -= speed * delta


	if position.x < -200:
		queue_free() 
