using Godot;

namespace TrainYourDragon.Minigames
{
	public partial class Coinflip : Control
	{
		private Button _coinButton;
		private Sprite2D _coinSprite;
		private Label _coins;
		private Label _coinFace;
		private Label _instructions;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
		}

		// Called every frame. 'delta' is the elapsed time since the previous frame.
		public override void _Process(double delta)
		{
			
		}

		private void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}
	}
}