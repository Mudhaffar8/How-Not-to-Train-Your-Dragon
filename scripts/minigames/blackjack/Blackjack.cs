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

        public override string ToString() => $"({Value} of {Suit})";
    }

    public enum CardSuits : ushort { HEARTS, SPADES, CLUBS, DIAMONDS }
	public enum CardValues : ushort { ACE=1, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }

	/// <summary>
	/// Game Manager for Blackjack Minigame
	/// </summary>
	public partial class Blackjack : Control
	{
        private enum CardPlayer { PLAYER, DEALER }

		private const int BetAmount = 20;
		private const int MaxScore = 21;
		private const int MaxDeckSize = 52;

		private List<Card> _deck = new(MaxDeckSize);
		private CardHand _playerHand = new("Player");
		private CardHand _dealerHand = new("Dealer");

		private Random _rng = new();

		private Button _startButton;
		private Button _hitButton;
		private Button _standButton;
		private Button _exitButton;
		private Label _playerCoins;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_playerCoins = GetNode<Label>("%Score");
			_startButton = GetNode<Button>("StartButton");
			_exitButton = GetNode<Button>("BackButton");
			_hitButton = GetNode<Button>("HitButton");
			_standButton = GetNode<Button>("StandButton");

            UpdateCoinsLabel();
            DisableGameButtons();
		}


		private void OnStartButtonPressed()
		{
            if (GameManager.Coins < BetAmount)
                return;

            BuildDeck();
            
			GameManager.Coins -= BetAmount;
			UpdateCoinsLabel();

            _playerHand.ReleaseAllCards();
            _dealerHand.ReleaseAllCards();

			DealRandomCard(_playerHand);
			DealRandomCard(_playerHand);

			DealRandomCard(_dealerHand);
			DealRandomCard(_dealerHand);

            _playerHand.PrintDeck();
            _dealerHand.PrintDeck();

            EnableGameButtons();
		}

		private void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}

		private void BuildDeck()
		{
			foreach (CardSuits suit in Enum.GetValues(typeof(CardSuits)))
			{
				foreach (CardValues value in Enum.GetValues(typeof(CardValues)))
				{
					_deck.Add(new Card(suit, value));
				}
			}
		}

		private void OnHitButtonPressed()
        {
            DealRandomCard(_playerHand);
            _playerHand.PrintDeck();
            
            if (_playerHand.Score > MaxScore)
            {
                GD.Print("Gamer Over!");
                DisableGameButtons();
            }
        }

        private void OnStandButtonPressed()
        {
            while (_dealerHand.Score <= _playerHand.Score && _dealerHand.Score != MaxScore)
            {
                DealRandomCard(_dealerHand);
                _dealerHand.PrintDeck();
            }

            if (_dealerHand.Score == MaxScore)
            {
                if (_playerHand.Score == MaxScore)
                {
                    GD.Print("Tie Game");
                }
                else
                {
                    GD.Print("Dealer Wins!");
                }
            }
            else if (_dealerHand.Score > MaxScore) 
                TriggerPlayerWins();

            else if (_dealerHand.Score > _playerHand.Score)
            {
                GD.Print("Dealer Wins!");
            }
            else
                TriggerPlayerWins();

            DisableGameButtons();
        }

		private void DealRandomCard(CardHand cardHand)
		{
			int randIndex = _rng.Next(0, _deck.Count);

			cardHand.AddCard(_deck[randIndex]);
			_deck.RemoveAt(randIndex);
		}

		private void UpdateCoinsLabel()
		{
			_playerCoins.Text = "Your Coins: " + GameManager.Coins + " Coins\n";
			_playerCoins.Text += "Bet Amount: " + BetAmount + " Coins";
		}

        private void TriggerPlayerWins()
        {
            GD.Print("Player Wins!");
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
	}
}