extends Node2D

@onready var button = $Button
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label3.text = "Your money: \n" + str(globals.coins) + " coins."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass


func _on_button_pressed() -> void:
	if globals.coins < 10:
		pass
	$AnimatedSprite2D.play()
	$Timer.start()
	globals.coins -= 10

func _on_timer_timeout() -> void:
	var my_random_number = rng.randi_range(0, 1)
	
	print(my_random_number)
	
	if my_random_number == 1:
		print("Heads")
		$Label.text = "Heads"
		globals.coins += 20
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.pause()
	
	elif my_random_number == 0:
		print("Tails")
		$Label.text = "Tails"
		globals.coins -= 5
		$AnimatedSprite2D.frame = 4
		$AnimatedSprite2D.pause()
	_update_coins_label()

func _update_coins_label() -> void:
	$Label3.text = "Your money \n" + str(globals.coins) + " coins."
