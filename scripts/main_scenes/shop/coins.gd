extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = str(globals.coins)
	
	if globals.food > 100 || globals.food < 0 || globals.fun < 0 || globals.health < 0:
		scene_switcher.switch_scene("res://scenes/endings/badending.tscn")


func _on_buy_1_pressed() -> void:
	if globals.coins >= 15:
		globals.coins -= 15
		globals.food += 10
		_purchased()
	else:
		_not_enough()

	$Timer.start() 
	

	
		
func _on_buy_2_pressed() -> void:
	if globals.coins >= 15:
		globals.coins -= 15
		globals.food += 5
		globals.fun += 5
		_purchased()
	else:
		_not_enough()
	
	$Timer.start() 


func _on_buy_3_pressed() -> void:
	if globals.coins >= 35:
		globals.coins -= 35
		globals.food += 5
		globals.health += 15
		globals.fun -= 10
		_purchased()
	else:
		_not_enough()
	
	$Timer.start() 


func _on_buy_4_pressed() -> void:
	if globals.coins >= 550:
		globals.coins -= 550
		globals.food += 90
		_purchased()
	else:
		_not_enough()
	
	$Timer.start() 


func _on_buy_5_pressed() -> void:
	if globals.coins >= 33:
		globals.coins -= 33
		globals.food += 10
		globals.health += 10
		_purchased()
	else:
		_not_enough()
	
	$Timer.start() 


func _on_buy_6_pressed() -> void:
	if globals.coins >= 70:
		globals.coins -= 70
		globals.fun += 70
		globals.health -= 30
		_purchased()
	else:
		_not_enough()
	
	$Timer.start() 

func _on_timer_timeout() -> void:
	$ErrorLabel.visible = false
	$"../Sprite2D".visible = false

func _purchased():
	$ErrorLabel.text = "Purchased!"
	$ErrorLabel.visible = true
	$"../Sprite2D".visible = true

func _not_enough():
	$ErrorLabel.text = "You're too poor!"
	$ErrorLabel.visible = true
	$"../Sprite2D".visible = true
