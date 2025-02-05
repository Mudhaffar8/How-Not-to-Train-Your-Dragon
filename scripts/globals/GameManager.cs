/// <summary>
/// Static class for storing variables used across differents scenes.
/// </summary>
/// <example>
/// Example usage:
/// <code>
/// GameManager.Rotations = 1;
/// </code>
/// </example>
public static class GameManager
{
    // Coins
    public static int Coins { get; set; } = 50;
    public static int CoinsEarned { get; set; } = 0; // For minigames

    // Goober's Base Stats.
    public static float Food { get; set; } = 50.0f;
    public static float Fun { get; set; } = 50.0f;
    public static float Health { get; set; } = 50.0f;

    // Managing Goober's States.
    public static int Seconds { get; set; } = 0;
    public static int MainTime { get; set; } = 50;
    public static int EggTime { get; } = 50;
    public static int BabyTime { get; } = 50;
    public static int TeenTime { get; } = 50;
}
