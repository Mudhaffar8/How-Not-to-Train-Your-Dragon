using Godot;

namespace TrainYourDragon.Endings
{
    public partial class Goodending : Control
    {
        private void OnRestartPressed()
        {
            Utils.ResetGame();
        }
    }
}