using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	// Should prolly just make this a CharacterBody2D
	public partial class Player : Node2D
	{
		private const float Gravity = 1000.0f;
		private const float JumpStrength = -500.0f;
		
		private CharacterBody2D _body;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_body = GetNode<CharacterBody2D>("CharacterBody2D");
			AddToGroup("Game");
		}

        public override void _PhysicsProcess(double delta)
        {
			if (!_body.IsOnFloor())
				_body.Velocity = new Godot.Vector2(_body.Velocity.X, _body.Velocity.Y + Gravity * (float)delta);
	
			if (Input.IsActionJustPressed("jump"))
				_body.Velocity = new Godot.Vector2(_body.Velocity.X, JumpStrength);
		
			_body.MoveAndSlide();
		}
	}
}