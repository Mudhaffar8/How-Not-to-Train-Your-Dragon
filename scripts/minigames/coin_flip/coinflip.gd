extends Control


@onready var coin_button = $CoinButton
@onready var coin_sprite = $CoinSprite
@onready var coin_count = $CoinCount
@onready var coin_face = $CoinFace
@onready var instructions1 = $Instructions1

var rng = RandomNumberGenerator.new()
var coinsPerGame = 10
var inGame = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_count.text = "Your money: \n" + str(globals.coins) + " coins."
	inGame = false


func _on_button_pressed() -> void:
	if globals.coins < coinsPerGame:
		return
	if inGame:
		return
	instructions1.visible = false
	coinsPerGame = 10
	globals.coins -= coinsPerGame
	globals.fun += 3
	
	coin_sprite.play()
	inGame = true
	$Timer.start()
	

func _on_timer_timeout() -> void:
	var my_random_number = rng.randi_range(0, 1)
	
	print(my_random_number)
	
	if my_random_number == 1:
		print("Heads")
		coin_face.text = "Heads"
		globals.coins += coinsPerGame * 2
		coin_sprite.frame = 0
		coin_sprite.pause()
	
	else:
		print("Tails")
		coin_face.text = "Tails"
		globals.coins -= coinsPerGame / 2
		coin_sprite.frame = 6
		coin_sprite.pause()
		if globals.coins < 0:
			scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
			
	_update_coins_label()
	inGame = false
	


func _update_coins_label() -> void:
	coin_count.text = "Your money: \n" + str(globals.coins) + " coins."


func _on_button_2_pressed() -> void:
	instructions1.visible = false
	if inGame or globals.coins <= 0:
		return
	coinsPerGame = globals.coins
	globals.coins = 0
	globals.fun += 5
	_update_coins_label()
	coin_sprite.play()
	inGame = true
	$Timer.start()


func _on_button_3_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")
