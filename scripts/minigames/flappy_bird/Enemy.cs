using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	/// <summary>
	/// Game Manager for Flappy bird Minigame
	/// </summary>
	public partial class Enemy : Node2D
	{
        private const float Speed = 200.0f;

		// Called every frame. 'delta' is the elapsed time since the previous frame.
		public override void _Process(double delta)
        {
            Position = new Vector2(Speed * (float)delta, Position.Y);

            if (Position.X < -350.0f)
                QueueFree();
        }

        public static void OnArea2DBodyEntered(Node2D body)
        {
            if (body.Name == "CharacterBody2D")
                SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_GAME_OVER);
        }
	}
}