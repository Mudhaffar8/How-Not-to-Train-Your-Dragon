using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	// Should prolly just make this a CharacterBody2D
	public partial class Player : Node2D
	{
		private const float Gravity = 1000.0f;
		private const float JumpStrength = -500.0f;
		
		public bool IsGameOver { get; set; } = false;

		private CharacterBody2D _characterBody;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_characterBody = GetNode<CharacterBody2D>("CharacterBody2D");
			AddToGroup("Game");
		}

        public override void _PhysicsProcess(double delta)
        {
            if (IsGameOver) return;

			if (!_characterBody.IsOnFloor())
				_characterBody.Velocity = new Godot.Vector2(_characterBody.Velocity.X, Gravity * (float)delta);
	
			if (Input.IsActionJustPressed("jump"))
				_characterBody.Velocity = new Godot.Vector2(_characterBody.Velocity.X, JumpStrength);
		
			_characterBody.MoveAndSlide();
		}
	}
}