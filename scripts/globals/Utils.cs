/// <summary>
/// Static class for storing functions & enums used across differents scenes.
/// </summary>
/// <example>
/// Example usage:
/// <code>
/// Utils.TestFunc();
/// </code>
/// </example>
public static class Utils
{
    public static void ResetGame()
    {
        GameManager.Food = 50;
        GameManager.Health = 50;
        GameManager.Fun = 50;
        GameManager.Coins = 50;
        GameManager.Seconds = 0;

        SceneManager.Instance.SwitchScene("res://scenes/main_scenes/main.tscn");
    }
}