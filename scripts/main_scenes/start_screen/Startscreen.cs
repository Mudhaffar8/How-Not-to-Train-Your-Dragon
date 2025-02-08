using Godot;

namespace TrainYourDragon.MainScenes
{
    public partial class Startscreen : Control
    {
        private void OnMainButtonPressed() 
        {
            SceneManager.Instance.SwitchScene(GameScenes.MAIN_HUB);
        }
    }
}
