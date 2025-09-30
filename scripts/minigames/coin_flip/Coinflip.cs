using System;
using Godot;

namespace TrainYourDragon.Minigames
{
	/// <summary>
	/// Game Manager for Coinflip Minigame
	/// </summary>
	public partial class Coinflip : Control
	{
		private Button _coinButton;
		private Sprite2D _coinSprite;
		private Label _coins;
		private Label _coinFace;
		private Label _instructions;

		private Random _rng;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{

		}

		private void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}
	}
}