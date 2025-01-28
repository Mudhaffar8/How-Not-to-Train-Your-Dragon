extends Control

var deck: Array = []
var rng = RandomNumberGenerator.new()
var dealerCards = []
var playerCards = []
var nums = []

var offset_x = 25
var current_position_p = Vector2(450, 400) # Initial position
var current_index_p = 1 # Start with the first texture
var current_position_d = Vector2(450, 150) # Initial position
var current_index_d = 1 # Start with the first texture

var first_sprite: Sprite2D = null
var bet_amount = 20

func generate_deck() -> Array:
	var suits = ["H", "D", "C", "S"]
	var ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	var deck = []

	for suit in suits:
		for rank in ranks:
			deck.append(rank + suit)
	return deck
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = generate_deck()
	$Label.text = "Your coins: " + str(globals.coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass



func _on_button_pressed() -> void:
	if globals.coins < bet_amount:
		return
	$Button.disabled = true
	$Button2.disabled = false
	$Button3.disabled = false
	$TextureRect3.text = ""
	first_sprite = null
	
	var children = get_children()
	globals.coins -= bet_amount
	$Label.text = "Your coins: " + str(globals.coins)
	
	for child in children:
		if child is Sprite2D:
			child.queue_free()
	current_position_p = Vector2(450, 400) # Initial position
	current_index_p = 1 # Start with the first texture
	current_position_d = Vector2(450, 150) # Initial position
	current_index_d = 1 # Start with the first texture

	if len(deck) <= 5:
		deck = generate_deck() 
	
	dealerCards = []
	playerCards = []
	
	var i = 4
	while i > 0:
		await get_tree().create_timer(0.85).timeout
		var ranCard = rng.randi_range(0, len(deck)-1)
		
		if i > 2:
			dealerCards.append(deck[ranCard])
			if i == 4:
				_put_new_card(deck[ranCard], "d", true)
			else:
				_put_new_card(deck[ranCard], "d")
		else:
			playerCards.append(deck[ranCard])
			_put_new_card(deck[ranCard], "p")
		deck.erase(deck[ranCard])
		i -= 1
	#$TextureRect2.text = "xxxxxxx, " + dealerCards[1]
	#$TextureRect4.text = playerCards[0] + ", " + playerCards[1]
	_hands_to_text(true)
	_win_con_first()
	
func _on_button_2_pressed() -> void:
	if len(deck) <= 1:
		deck = generate_deck() 
	var ranCard = rng.randi_range(0, len(deck) - 1)
	playerCards.append(deck[ranCard])
	deck.erase(deck[ranCard])
	#$TextureRect4.text += ", " +playerCards[-1]
	_put_new_card(playerCards[-1], "p")
	_hands_to_text(true)
	_win_con(true)
	
func _on_button_3_pressed() -> void:
	$Button2.disabled = true
	$Button3.disabled = true
	#$TextureRect2.text = dealerCards[0] + ", " + dealerCards[1]
	_switch_closed_card()
	while(_hand_to_num(dealerCards) < 17):
		await get_tree().create_timer(0.85).timeout
		if len(deck) <= 1:
			deck = generate_deck() 
		var ranCard = rng.randi_range(0, len(deck) - 1)
		dealerCards.append(deck[ranCard])
		deck.erase(deck[ranCard])
		#$TextureRect2.text += ", " +dealerCards[-1]
		_put_new_card(dealerCards[-1], "d")
	_hands_to_text()
	_win_con()

func _hand_to_num(hand, deal = false):
	nums = []
	for i in hand:
		if not i[0].to_int() == 0:
			if int(i[0]) == 1:
				nums.append(10)
			else:
				nums.append(int(i[0]))
		else:
			if i[0] == "A":
				nums.append(11)
			else: nums.append(10)
	
	while nums.reduce(sum, 0) > 21 and nums.has(11):
		nums[nums.find(11)] = 1
	if deal == true:
		nums[0] = 0
	return nums.reduce(sum, 0)
	
func _hands_to_text(deal = false):
	var player = _hand_to_num(playerCards)
	var dealer = _hand_to_num(dealerCards, deal)
	$TextureRect5.text = "Dealer: " + str(dealer)
	$TextureRect6.text = "Player: " + str(player)

func _win_con_first():
	var dealer = _hand_to_num(dealerCards)
	var player = _hand_to_num(playerCards)
	if player == 21 and not dealer == 21:
		_round_over("pb")
		
func _win_con(x = false):
	var dealer = _hand_to_num(dealerCards)
	var player = _hand_to_num(playerCards)
	if dealer < 21 && player < 21 && x:
		#win not achieved
		return
	if player == 21 && dealer != 21:
		#player wins
		_round_over("pb")
		return
	elif dealer == 21 && player != 21:
		_round_over("db")
		return
	if player > 21 && dealer < 21:
		_round_over("d")
		return
	if dealer > 21 && player < 21:
		_round_over("p")
		return
	
	if player == dealer:
		#push
		_round_over("push")
		return
	if dealer > player:
		#bust
		_round_over("d")
		return
	if player > dealer:
		#bust
		_round_over("p")
		return
	
	
func sum(accum, number):
	return accum + number

func _on_button_4_pressed() -> void:
	scene_switcher.switch_scene("res://scenes/main_scenes/main.tscn")
	
func _round_over(winner):
	$Button2.disabled = true
	$Button3.disabled = true
	$Button.disabled = false
	#$TextureRect2.text = ""
	_switch_closed_card()
	_hands_to_text()
	#for i in dealerCards:
		#$TextureRect2.text += i +", "
	#var text = $TextureRect2.text
	#$TextureRect2.text = text.substr(0, len(text) - 2)
	
	if winner == "pb":
		$TextureRect3.text = "Player wins by BlackJack"
		globals.coins += bet_amount * 3 / 2
	elif winner == "push":
		$TextureRect3.text = "Push. Nobody wins"
		globals.coins += bet_amount
	elif winner == "p":
		$TextureRect3.text = "Player wins by Bust"
		globals.coins += bet_amount * 2
	elif winner == "db":
		$TextureRect3.text = "Dealer wins by BlackJack"
	elif winner == "d":
		$TextureRect3.text = "Dealer wins by Bust"
	$Label.text = "Your coins: " + str(globals.coins)
	globals.fun += 4

func _put_new_card(card, player, first = false):
	var texture_path = "res://assets/minigames/blackjack/" + card +  ".png"
	if first:
		texture_path = "res://assets/minigames/blackjack/green_back.png"
	
	var new_sprite = Sprite2D.new()
	var texture = load(texture_path)
	new_sprite.scale = Vector2(0.15, 0.15)
	new_sprite.texture = texture
	if player == "d":
		new_sprite.position = current_position_d
		current_position_d.x += offset_x
		current_index_d += 1
	else:
		new_sprite.position = current_position_p
		current_position_p.x += offset_x
		current_index_p += 1

	if first_sprite == null:
		first_sprite = new_sprite
	
	add_child(new_sprite)

func _switch_closed_card():
	var texture_path = "res://assets/minigames/blackjack/" + dealerCards[0] +  ".png"
	var texture = load(texture_path)
	first_sprite.texture = texture
