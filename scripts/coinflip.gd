extends Node2D

@onready var button = $Button
var rng = RandomNumberGenerator.new()
var coinsPerGame = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label3.text = "Your money: \n" + str(globals.coins) + " coins."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	print(globals.coins)


func _on_button_pressed() -> void:
	coinsPerGame = 10
	if globals.coins < coinsPerGame:
		pass #should skip function heree
	globals.coins -= coinsPerGame
	globals.fun += 5
	$AnimatedSprite2D.play()
	$Timer.start()
	

func _on_timer_timeout() -> void:
	var my_random_number = rng.randi_range(0, 1)
	
	print(my_random_number)
	
	if my_random_number == 1:
		print("Heads")
		$Label.text = "Heads"
		globals.coins += coinsPerGame * 2
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.pause()
	
	elif my_random_number == 0:
		print("Tails")
		$Label.text = "Tails"
		globals.coins -= coinsPerGame / 2
		$AnimatedSprite2D.frame = 4
		$AnimatedSprite2D.pause()
		if globals.coins < 0:
			scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
	_update_coins_label()

func _update_coins_label() -> void:
	$Label3.text = "Your money: \n" + str(globals.coins) + " coins."


func _on_button_2_pressed() -> void:
	coinsPerGame = globals.coins
	globals.coins = 0
	globals.fun += 10
	_update_coins_label()
	$AnimatedSprite2D.play()
	$Timer.start()
	


func _on_button_3_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main.tscn")
