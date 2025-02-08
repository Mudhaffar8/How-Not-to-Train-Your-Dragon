using Godot;
using System.Collections.Generic;

/// <summary> 
/// Static class for switching between scenes in Godot. 
/// </summary>

namespace TrainYourDragon
{
    public enum GameScenes 
    {
        START_SCREEN,
        MAIN_HUB,
        SHOP,
        MINIGAMES_HUB,
        BLACKJACK,
        COIN_FLIP,
        FLAPPY_BIRD,
        FLAPPY_GAME_OVER,
        BAD_ENDING,
        GOOD_ENDING
    }
    
    public partial class SceneManager : Node
    {
        public static SceneManager Instance { get; private set; }

        private Dictionary<GameScenes, string> _gameScenes = new()
        {
            {GameScenes.START_SCREEN, "res://scenes/main_scenes/startscreen.tscn"},
            {GameScenes.MAIN_HUB, "res://scenes/main_scenes/main.tscn"},
            {GameScenes.SHOP, "res://scenes/main_scenes/shop.tscn"},
            {GameScenes.MINIGAMES_HUB, "res://scenes/main_scenes/minigames.tscn"},
            {GameScenes.BLACKJACK, "res://scenes/minigames/blackjack/blackjack.tscn"},
            {GameScenes.COIN_FLIP, "res://scenes/minigames/coin_flip/coinflip.tscn"},
            {GameScenes.FLAPPY_BIRD, "res://scenes/minigames/flappy_bird/flappy_mini.tscn"},
            {GameScenes.FLAPPY_GAME_OVER, "res://scenes/minigames/flappy_bird/gameOverMini.tscn"},
            {GameScenes.BAD_ENDING, "res://scenes/endings/badending.tscn"},
            {GameScenes.GOOD_ENDING, "res://scenes/endings/goodending.tscn"}
        };

        private AnimationPlayer _animPlayer;
        private Node _currScene;
        private PackedScene _newScene;


        public override void _Ready()
        {
            // Get the main scene and set it as the current scene
            Node root = GetTree().Root;
            _currScene = root.GetChild(root.GetChildCount() - 1);

            _animPlayer = GetNode<AnimationPlayer>("AnimationPlayer");

            Instance = this;
        }

        /// <summary>
        /// Switches the current scene to a new scene.
        /// </summary>
        /// <param name="path">Path to the new scene.</param>
        /// <example>
        /// Example usage:
        /// <code>
        /// SceneManager.Instance.SwitchScene("res://scenes/name_of_scene.tscn");
        /// </code>
        /// </example>
        /// <remarks>
        /// The SwitchScene method will load the specified scene and transition to it. 
        /// Make sure the scene path is valid and the scene is properly set up.
        /// </remarks>
        public void SwitchScene(GameScenes gameScene) 
        {
            string path = _gameScenes[gameScene];
            CallDeferred(nameof(DefferedSwitchScene), path);
        }

        private async void DefferedSwitchScene(string path)
        {
            // Fade in
            _animPlayer.Play("fade");
            _ = await ToSignal(_animPlayer, AnimationPlayer.SignalName.AnimationFinished);

            // Free current scene and load new scene
            _currScene.Free();
            _newScene = GD.Load<PackedScene>(path);
            _currScene = _newScene.Instantiate();

            // Set new scene as current scene
            GetTree().Root.AddChild(_currScene);
            GetTree().CurrentScene = _currScene;

            // Fade out
            _animPlayer.PlayBackwards("fade");
            _ = await ToSignal(_animPlayer, AnimationPlayer.SignalName.AnimationFinished);
        }
    }
}