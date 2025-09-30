using Godot;

namespace TrainYourDragon.MainScenes
{
    public partial class Startscreen : Control
    {
        private static void OnMainButtonPressed() 
        {
            SceneManager.Instance.SwitchScene(GameScenes.MAIN_HUB);
        }
    }
}
