extends Control

var deck: Array = []
var rng = RandomNumberGenerator.new()
var dealerCards = []
var playerCards = []
var nums = []

func generate_deck() -> Array:
	var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
	var ranks = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
	var deck = []

	for suit in suits:
		for rank in ranks:
			deck.append(rank + suit)
	return deck
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = generate_deck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	$Button.disabled = true
	$Button2.disabled = false
	$Button3.disabled = false
	$TextureRect3.text = ""
	
	dealerCards = []
	playerCards = []
	
	var i = 4
	while i > 0:
		
		var ranCard = rng.randi_range(0, len(deck)-1)
		
		if i > 2:
			dealerCards.append(deck[ranCard])
		else:
			playerCards.append(deck[ranCard])
		deck.erase(deck[ranCard])
		i -= 1
	$TextureRect2.text = "xxxxxxx, " + dealerCards[1]
	$TextureRect4.text = playerCards[0] + ", " + playerCards[1]
	_hands_to_text(true)
	_win_con_first()
	
func _on_button_2_pressed() -> void:
	var ranCard = rng.randi_range(0, len(deck) - 1)
	playerCards.append(deck[ranCard])
	deck.erase(deck[ranCard])
	$TextureRect4.text += ", " +playerCards[-1]
	_hands_to_text(true)
	_win_con(true)
	
func _on_button_3_pressed() -> void:
	$Button2.disabled = true
	$Button3.disabled = true
	$TextureRect2.text = dealerCards[0] + ", " + dealerCards[1]
	while(_hand_to_num(dealerCards) < 17):
		var ranCard = rng.randi_range(0, len(deck) - 1)
		dealerCards.append(deck[ranCard])
		deck.erase(deck[ranCard])
		$TextureRect2.text += ", " +dealerCards[-1]
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
	print(dealer)
	print( player)
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
	if winner == "pb":
		$TextureRect3.text = "Player wins by BlackJack"
	elif winner == "push":
		$TextureRect3.text = "Push. Nobody wins"
	elif winner == "p":
		$TextureRect3.text = "Player wins by Bust"
	elif winner == "db":
		$TextureRect3.text = "Dealer wins by BlackJack"
	elif winner == "d":
		$TextureRect3.text = "Dealer wins by Bust"
