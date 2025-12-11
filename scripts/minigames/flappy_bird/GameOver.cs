using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	public partial class GameOver : Control
	{
		private const int HealthLoss = 7;

		private Label _coinsCollectedLabel;
		private Label _totalCoinsLabel;
		private Label _funCollectedLabel;
		private Label _healthLossLabel;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
        {
			_coinsCollectedLabel = GetNode<Label>("Container/MarginContainer/ResultsContainer/VBoxContainer/CoinsCollected");
			_funCollectedLabel = GetNode<Label>("Container/MarginContainer/ResultsContainer/VBoxContainer/FunCollected");
		    _totalCoinsLabel = GetNode<Label>("Container/MarginContainer/ResultsContainer/VBoxContainer2/TotalCoins");
			_healthLossLabel = GetNode<Label>("Container/MarginContainer/ResultsContainer/VBoxContainer2/HealthLost");
			
			GameManager.Coins += GameManager.CoinsEarned;
			GameManager.Health -= HealthLoss;

			_coinsCollectedLabel.Text = "Coins collected: " + GameManager.CoinsEarned;
			_totalCoinsLabel.Text = "Total coins: " + GameManager.Coins;
			_funCollectedLabel.Text = "Fun collected: " + (GameManager.CoinsEarned / 3);
			_healthLossLabel.Text = "Total health: " + GameManager.Health + $" (-{HealthLoss})";
        }

		private static void OnRestartButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_BIRD);
		}

		private static void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}
	}
}