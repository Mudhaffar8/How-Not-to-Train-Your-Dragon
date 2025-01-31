using Godot;

public partial class Startscreen : Control
{
    private void OnMainButtonPressed() 
    {
        SceneManager.Instance.SwitchScene("res://scenes/main_scenes/main.tscn");
    }
}
