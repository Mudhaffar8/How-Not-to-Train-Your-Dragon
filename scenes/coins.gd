extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = "Coins: " + str(globals.coins)
	
		


func _on_coins_button_pressed() -> void:
	globals.coins += 500

func _on_buy_1_pressed() -> void:
	if globals.coins >= 15:
		globals.coins -= 15
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
		
func _on_buy_2_pressed() -> void:
	if globals.coins >= 10:
		globals.coins -= 10
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
		
func _on_buy_3_pressed() -> void:
	if globals.coins >= 23:
		globals.coins -= 23
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
	
func _on_buy_4_pressed() -> void:
	if globals.coins >= 550:
		globals.coins -= 550
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true

func _on_buy_5_pressed() -> void:
	if globals.coins >= 19:
		globals.coins -= 19
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
		
func _on_buy_6_pressed() -> void:
	if globals.coins >= 423:
		globals.coins -= 423
		$ErrorLabel.text = "Purchased!"
		$ErrorLabel.visible = true
	else:
		$ErrorLabel.text = "You're too poor!"
		$ErrorLabel.visible = true
		

		
