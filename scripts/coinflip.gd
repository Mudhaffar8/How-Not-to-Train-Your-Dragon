extends Node2D

@onready var button = $Button
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass


func _on_button_pressed() -> void:
	$AnimatedSprite2D.play()
	$Timer.start()

func _on_timer_timeout() -> void:
	var my_random_number = rng.randi_range(0, 1)
	
	print(my_random_number)
	
	if my_random_number == 1:
		print("Heads")
		$Label.text = "Heads"
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.pause()
	
	elif my_random_number == 0:
		print("Tails")
		$Label.text = "Tails"
		$AnimatedSprite2D.frame = 4
		$AnimatedSprite2D.pause()

	
