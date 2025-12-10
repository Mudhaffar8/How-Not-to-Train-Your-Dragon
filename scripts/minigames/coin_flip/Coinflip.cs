using System;
using Godot;

namespace TrainYourDragon.Minigames
{
	/// <summary>
	/// Game Manager for Coinflip Minigame
	/// </summary>
	public partial class Coinflip : Control
	{
		private AnimatedSprite2D _coinSprite;
		private Button _coinFlipButton;
		private Label _coinCount;
		private Label _coinLabelFace;
		private Label _instructions;
		private Timer _timer;

		// For coin-flip logic 
		private Random _rng = new();

		/// <summary>
        /// Indiciates whether the coin is in the middle of flipping or not.
		/// Prevents player from using the All-In or Coin button while the coin is flipping.
        /// </summary>
		private bool _inGame = false;
		
		private int _coinsPerGame = 10;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_coinFlipButton = GetNode<Button>("CoinButton");
			_coinSprite = GetNode<AnimatedSprite2D>("CoinSprite");
			_coinCount = GetNode<Label>("Text/CoinCount");
			_coinLabelFace = GetNode<Label>("Text/CoinFace");
			_instructions = GetNode<Label>("Text/Instructions2");
			_timer = GetNode<Timer>("Timer");

			UpdateCoinsLabel();
			_inGame = false;
		}

		/// <summary>
        /// Performs a coin-flip outcome, updates UI, modifies the player's coin total,
		/// and triggers a bad-ending scene if player's coins fall below zero.
        /// </summary>
		private void OnTimerTimeout()
        {
            bool isHeads = _rng.Next(0, 2) == 1;

			//GD.Print(isHeads ? "Heads" : "Tails");

			if (isHeads)
            {
				_coinLabelFace.Text = "Heads";
                GameManager.Coins += _coinsPerGame * 2;
				_coinSprite.Frame = 0;
				_coinSprite.Pause();
			}
			else
            {
				_coinLabelFace.Text = "Tails";
                GameManager.Coins -= _coinsPerGame / 2; 
				_coinSprite.Frame = 6;
				_coinSprite.Pause();

				if (GameManager.Coins < 0)
					SceneManager.Instance.SwitchScene(GameScenes.BAD_ENDING);
            }	

			UpdateCoinsLabel();
			_inGame = false;
        }

		private void OnCoinButtonPressed()
        {
            if (GameManager.Coins < _coinsPerGame || _inGame) return;

			_instructions.Visible = false;

			GameManager.Coins -= _coinsPerGame;
			GameManager.Fun += 3;

			_coinSprite.Play();
			_inGame = true;

			_timer.Start();
        }

		private void OnAllInButtonPressed()
        {
            _instructions.Visible = false;
			
			if (GameManager.Coins <= _coinsPerGame || _inGame) return;

			_coinsPerGame = GameManager.Coins;
			GameManager.Coins = 0;
			GameManager.Fun += 5;

			UpdateCoinsLabel();

			_coinSprite.Play();

			_inGame = true;
			_timer.Start();
        }

		private void UpdateCoinsLabel()
        {
            _coinCount.Text = "Your Money: \n" + GameManager.Coins + " coins.";
        }


		private static void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}
	}
}