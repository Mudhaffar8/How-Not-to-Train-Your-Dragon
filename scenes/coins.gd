extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = str(globals.coins)
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")
	

func _on_coins_button_pressed() -> void:
	globals.coins += 500

func _on_buy_1_pressed() -> void:
	if globals.coins >= 15:
		globals.coins -= 15
		globals.food += 20
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
	
func _on_timer_timeout() -> void:
	$ErrorLabel.visible = false
	
		
func _on_buy_2_pressed() -> void:
	if globals.coins >= 10:
		globals.coins -= 10
		globals.food += 10
		globals.fun += 5
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
		
func _on_buy_3_pressed() -> void:
	if globals.coins >= 23:
		globals.coins -= 23
		globals.food += 30
		globals.health += 5
		globals.fun -= 5
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
	
func _on_buy_4_pressed() -> void:
	if globals.coins >= 550:
		globals.coins -= 550
		globals.food += 90
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
	
func _on_buy_5_pressed() -> void:
	if globals.coins >= 19:
		globals.coins -= 19
		globals.food += 10
		globals.health += 10
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
		
func _on_buy_6_pressed() -> void:
	if globals.coins >= 423:
		globals.coins -= 423
		globals.fun += 69
		globals.health -= 15
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	$Timer.start() 
		

		
