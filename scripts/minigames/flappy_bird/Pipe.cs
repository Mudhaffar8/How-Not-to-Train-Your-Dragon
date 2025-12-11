using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	public partial class Pipe : Node2D
	{
        private const int Speed = 200;

        public override void _Ready()
        {
            AddToGroup("pipes");
        }

		public override void _Process(double delta)
        {
            Position = new Vector2(Position.X - (float)(Speed * delta), Position.Y);

            if (Position.X < -350)
                QueueFree();
        }

        private void OnBodyEntered(Node2D body)
        {
            if (body.Name == "CharacterBody2D")
                SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_GAME_OVER);
        }
	}
}