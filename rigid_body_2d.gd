extends Node2D

# Variables for movement
var gravity = 600.0
var jump_strength = -250.0
var velocity = Vector2.ZERO

func _process(delta):
	# Apply gravity
	velocity.y += gravity * delta
	
	# Check for jump input
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_strength

	# Update position
	position.y += velocity.y * delta

	# Optional: Clamp position to prevent the bird from falling off the screen
	position.y = clamp(position.y, 0, 800) # Adjust 800 to your screen height
