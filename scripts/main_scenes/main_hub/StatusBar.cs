using Godot;

namespace TrainYourDragon.MainScenes.MainHub
{
	public partial class StatusBar : Control
	{
		[Export] 
		public Texture2D Texture { get; private set; }
		
		public float Value 
		{
			get { return (float)_progressBar.Value; }
			set 
			{
				if (value < 0) 
				{
					_progressBar.Value = 0;
					return;
				}

				_progressBar.Value = value;
			}
		}

		private ProgressBar _progressBar;
		private TextureRect _textureNode;

		// Called when the node enters the scene tree for the first time.
		public override void _Ready()
		{
			_textureNode = GetNode<TextureRect>("HBoxContainer/TextureRect");
			_textureNode.Texture = Texture;

			_progressBar = GetNode<ProgressBar>("HBoxContainer/ProgressBar");
		}
	}
}