using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

namespace TrainYourDragon.Minigames.BlackJack
{    
    public readonly struct Card 
    {	
        public CardSuits Suit { get; init; }
        public CardValues Value { get; init; }

        public Card(CardSuits suit, CardValues value)
        {
            Suit = suit;
            Value = value;
        }

        public string GetURLPath()
        {
            return $"{Value}_{Suit}";
        }

        public override string ToString() => $"({Value} of {Suit})";
    }

    public enum CardSuits : ushort { HEARTS, SPADES, CLUBS, DIAMONDS }
	public enum CardValues : ushort { ACE=1, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }

	/// <summary>
	/// Game Manager for Blackjack Minigame
	/// </summary>
	public partial class Blackjack : Control
	{	
        private const int BetAmount = 20;
		private const int MaxScore = 21;
		private const int MaxDeckSize = 52;

		private List<Card> _deck = new(MaxDeckSize);
		private CardHand _playerHand = new("Player", new(450, 400));
		private CardHand _dealerHand = new("Dealer", new(450, 150));

		private Random _rng = new();

		private Button _startButton;
		private Button _hitButton;
		private Button _standButton;
		private Button _exitButton;
		private Label _playerCoins;
        private Label _gameResultsLabel;
        private Label _playerScoreLabel;
        private Label _dealerScoreLabel;


		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_startButton = GetNode<Button>("StartButton");
			_exitButton = GetNode<Button>("BackButton");
			_hitButton = GetNode<Button>("HitButton");
			_standButton = GetNode<Button>("StandButton");
            _playerCoins = GetNode<Label>("%Score");
            _gameResultsLabel = GetNode<Label>("GameResults");
            _playerScoreLabel = GetNode<Label>("PlayerScore");
            _dealerScoreLabel = GetNode<Label>("DealerScore");

            UpdateCoinsLabel();
            DisableGameButtons();
		}


		private void OnStartButtonPressed()
		{
            if (GameManager.Coins < BetAmount)
                return;

            // Get rid of Cards from previous match
            foreach (var child in GetChildren())
            {
                if (child is Sprite2D)
                    child.QueueFree();
            }

            _gameResultsLabel.Text = "";

            BuildDeck();
            
			GameManager.Coins -= BetAmount;
			UpdateCoinsLabel();

            _playerHand.ReleaseAllCards();
            _dealerHand.ReleaseAllCards();

			DealRandomCard(_playerHand, _playerScoreLabel);
			DealRandomCard(_playerHand, _playerScoreLabel);

			DealRandomCard(_dealerHand, _dealerScoreLabel);
			DealRandomCard(_dealerHand, _dealerScoreLabel);

            _playerHand.PrintDeck();
            _dealerHand.PrintDeck();

            EnableGameButtons();
		}

		private void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}

		private void OnHitButtonPressed()
        {
            DealRandomCard(_playerHand, _playerScoreLabel);
            _playerHand.PrintDeck();
            
            if (_playerHand.Score > MaxScore)
            {
                _gameResultsLabel.Text = "Dealer Wins!";
                DisableGameButtons();
            }
        }

        private void OnStandButtonPressed()
        {
            PlayDealerTurn();
            EvaluateWinner();
            DisableGameButtons();
        }

        private void BuildDeck()
		{
            _deck.Clear();
			foreach (CardSuits suit in Enum.GetValues(typeof(CardSuits)))
			{
				foreach (CardValues value in Enum.GetValues(typeof(CardValues)))
				{
					_deck.Add(new Card(suit, value));
				}
			}
		}

        private void PlayDealerTurn()
        {
            while (_dealerHand.Score <= _playerHand.Score && 
                _dealerHand.Score != MaxScore)
            {
                DealRandomCard(_dealerHand, _dealerScoreLabel);
                _dealerHand.PrintDeck();
            }
        }

        private void EvaluateWinner()
        {
            int dealer = _dealerHand.Score;
            int player = _playerHand.Score;

            if (dealer == MaxScore)
            {
                _gameResultsLabel.Text = (player == MaxScore) ? "Tie Game" : "Dealer Wins!";
            }
            else if (dealer > MaxScore)
            {
                TriggerPlayerWins();
            }
            else if (dealer > player)
            {
                _gameResultsLabel.Text = "Dealer Wins!";
            }
            else
            {
                TriggerPlayerWins();
            }
        }

		private void DealRandomCard(CardHand cardHand, Label label)
		{
			int randIndex = _rng.Next(0, _deck.Count);

            Card card = _deck[randIndex];
            PutCard(card, cardHand);

			cardHand.AddCard(card);
			_deck.RemoveAt(randIndex);

            label.Text = cardHand.CardHolderName + " Score: " + cardHand.Score;
		}

		private void UpdateCoinsLabel()
		{
			_playerCoins.Text = "Your Coins: " + GameManager.Coins + " Coins\n";
			_playerCoins.Text += "Bet Amount: " + BetAmount + " Coins";
		}

        private void TriggerPlayerWins()
        {
            _gameResultsLabel.Text = "Player Wins!";
            GameManager.Coins += BetAmount * 2;
            UpdateCoinsLabel();
        }

        private void DisableGameButtons()
        {
            _startButton.Disabled = false;
            _exitButton.Disabled = false;

            _hitButton.Disabled = true;
            _standButton.Disabled = true;
        }

        private void EnableGameButtons()
        {
            _hitButton.Disabled = false;
            _standButton.Disabled = false;

            _startButton.Disabled = true;
            _exitButton.Disabled = true;
        }

        private void PutCard(Card card, CardHand hand)
        {
            const int CardOffset = 45;

            string texturePath = 
                "res://assets/minigames/blackjack/" + card.GetURLPath() + ".png";

            Sprite2D cardSprite = new()
            {
                Scale = new(0.15f, 0.15f),
                Texture = (Texture2D)GD.Load(texturePath),
                Position = new(hand.InitPos.X + (CardOffset * hand.Cards.Count), hand.InitPos.Y)
            };

            AddChild(cardSprite);
        }
	}
}