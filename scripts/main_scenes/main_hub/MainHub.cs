using Godot;


namespace TrainYourDragon.MainScenes.MainHub
{
	public partial class MainHub : Control
	{
		private StatusBar _foodStatus;
		private StatusBar _funStatus;
		private StatusBar _healthStatus;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_foodStatus = GetNode<StatusBar>("%FoodStatus");
			_foodStatus.Value = GameManager.Food;

			_funStatus = GetNode<StatusBar>("%FunStatus");
			_funStatus.Value = GameManager.Fun;

			_healthStatus = GetNode<StatusBar>("%HealthStatus");
			_healthStatus.Value = GameManager.Health;
		}

		// Called every frame. 'delta' is the elapsed time since the previous frame.
		public override void _Process(double delta)
		{
		}

		private void OnShopButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.SHOP);
		}

		private void OnMinigamesButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MINIGAMES_HUB);
		}
	}
}