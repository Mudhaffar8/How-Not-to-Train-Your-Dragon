using Godot;

namespace TrainYourDragon.MainScenes
{
	public partial class MinigamesHub : Control
	{
		private void OnFlappyButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_BIRD);
		}

		private void OnCoinFlipButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.COIN_FLIP);
		}

		private void OnBlackjackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.BLACKJACK);
		}

		private void OnBackButtonPressed()
		{
			SceneManager.Instance.SwitchScene(GameScenes.MAIN_HUB);
		}
	}
}