using Godot;
using System;

namespace TrainYourDragon.Minigames.FlappyBird
{
	/// <summary>
	/// Game Manager for Flappy bird Minigame
	/// </summary>
	public partial class FlappyMini : Node2D
	{
		private const float ScrollSpeed = 10.0f;
		
		private Random _rng = new();

		private int _screenSize = DisplayServer.WindowGetSize().X;
		private int _initBgSize;
		
		private Label _coinCountLabel;
		private Label _instructionsLabel;
		private PackedScene _pipeUpperPreload;
		private PackedScene _pipeLowerPreload;
		private PackedScene _enemyPreload;
		private Sprite2D _bgSprite;
		private Timer _pipeSpawnTimer;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
        {
			_pipeUpperPreload = GD.Load<PackedScene>("res://scenes/minigames/flappy_bird/pipe.tscn");
			_pipeLowerPreload = GD.Load<PackedScene>("res://scenes/minigames/flappy_bird/pipedown.tscn");
			_enemyPreload = GD.Load<PackedScene>("res://scenes/minigames/flappy_bird/enemy.tscn");
			
			_coinCountLabel = GetNode<Label>("CoinCount");
			_instructionsLabel = GetNode<Label>("Instructions");
			_bgSprite = GetNode<Sprite2D>("BgSprite");
			_pipeSpawnTimer = GetNode<Timer>("PipeSpawnTimer");

			_initBgSize = (int)_bgSprite.Position.X;

			OnPipeSpawnTimerTimeout();

			GameManager.CoinsEarned = 0;

			_pipeSpawnTimer.Start();
        }

		private void OnPipeSpawnTimerTimeout()
        {
            _coinCountLabel.Text = "Coins collected: " + GameManager.CoinsEarned;
			_pipeSpawnTimer.WaitTime = _rng.Next(2, 5);

			GameManager.CoinsEarned += 3;
			GameManager.Fun++;

			int rand = _rng.Next(0, 101);
			if (rand > 20)
            {
                Node2D pipeUpper = (Node2D)_pipeUpperPreload.Instantiate();

				pipeUpper.Position = new Vector2(1100, (float)(_rng.NextDouble() * -100.0f));
				AddChild(pipeUpper);
			}

			int rand2 = _rng.Next(0, 101);
			if (rand2 > 20)
            {
                Node2D pipeLower = (Node2D)_pipeLowerPreload.Instantiate();
				pipeLower.Position = new Vector2(1100, (float)(_rng.NextDouble() * 100.0f));
				
				AddChild(pipeLower);
			}

			int rand3 = _rng.Next(0, 100);
			if (rand < 20 || rand2 < 20 && rand3 > 30)
            {
                Node2D enemy = (Node2D)_enemyPreload.Instantiate();
				enemy.Position = new Vector2(1300, (float)(_rng.NextDouble() * 60.0f + 280.0f));
	
				AddChild(enemy);
			}
        }

		// Called every frame. 'delta' is the elapsed time since the previous frame.
		public override void _PhysicsProcess(double delta)
        {
			if (Input.IsActionJustPressed("jump"))
				_instructionsLabel.Visible = false;

			// Scrolling Behaviour
			float newBgPositionX = (float)(_bgSprite.Position.X - (ScrollSpeed * delta));
			if (newBgPositionX <= -_initBgSize + _screenSize)
				_bgSprite.Position = new Vector2(_initBgSize, _bgSprite.Position.Y);
			else
				_bgSprite.Position = new Vector2(newBgPositionX, _bgSprite.Position.Y);
        }

		// Add collisions instead?
		private void OnTopBoundaryBodyEntered(Node2D body)
        {
            if (body.Name == "CharacterBody2D")
				SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_GAME_OVER);
        }
		
		private void OnBottomBoundaryBodyEntered(Node2D body)
        {
            if (body.Name == "CharacterBody2D")
				SceneManager.Instance.SwitchScene(GameScenes.FLAPPY_GAME_OVER);
        }
	}
}