using Godot;
using System;
using System.Collections.Generic;

namespace TrainYourDragon.Minigames
{
	/// <summary>
	/// Game Manager for Blackjack Minigame
	/// </summary>
	public partial class Blackjack : Control
	{
		private readonly struct Card 
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

		private enum CardSuits : ushort { HEARTS, SPADES, CLUBS, DIAMONDS }
		private enum CardValues : ushort { ACE=1, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }

		private const int BetAmount = 20;
		private const int MaxScore = 21;
		private const int MaxDeckSize = 52;

		private List<Card> _deck = new(MaxDeckSize);
		private List<Card> _playerHand = new(10);
		private List<Card> _dealerHand = new(10);

		private int _playerScore = 0;
		private int _dealerScore = 0;

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
			UpdateCoins();

			_startButton = GetNode<Button>("StartButton");
			_exitButton = GetNode<Button>("BackButton");
			_hitButton = GetNode<Button>("HitButton");
			_standButton = GetNode<Button>("StandButton");

			_startButton.Disabled = false;
			_exitButton.Disabled = false;
			_hitButton.Disabled = true;
			_standButton.Disabled = true;

			BuildDeck();
		}

		/// <summary>
		/// 
		/// </summary>
		private void OnStartButtonPressed()
		{
			_startButton.Disabled = true;
			_exitButton.Disabled = true;

			GameManager.Coins -= BetAmount;
			UpdateCoins();

			DealRandomCard(_playerHand, ref _playerScore);
			DealRandomCard(_playerHand, ref _playerScore);

			DealRandomCard(_dealerHand, ref _dealerScore);
			DealRandomCard(_dealerHand, ref _dealerScore);

            PrintDeck(_playerHand, _playerScore);
            PrintDeck(_dealerHand, _dealerScore);
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

		}

		private void DealRandomCard(List<Card> hand, ref int score)
		{
			int randIndex = _rng.Next(0, _deck.Count);

			hand.Add(_deck[randIndex]);
			score += 1;
			_deck.RemoveAt(randIndex);
		}

		private void UpdateCoins()
		{
			_playerCoins.Text = "Your Coins: " + GameManager.Coins + " Coins\n";
			_playerCoins.Text += "Bet Amount: " + BetAmount + " Coins";
		}

		private static void PrintDeck(List<Card> deck, int score)
		{
			GD.Print(string.Join(", ", deck));
			GD.Print(score);
		}
	}
}