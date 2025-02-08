using Godot;
using System;
using System.Collections.Generic;

namespace TrainYourDragon.Endings
{
	public partial class Badending : Control
	{
		private Label _deathLabel;

		private Dictionary<Func<bool>, string> _deathReasons = new() 
		{
			{ () => GameManager.Food <= 0, "Goober starved\n to death" },
			{ () => GameManager.Food > 100, "Goober was overfed." },
			{ () => GameManager.Fun <= 0, "Goober died of boredom." },
			{ () => GameManager.Health <= 0, "Goober died of\n health complications."},
			{ () => GameManager.Coins <= 0, "Goober died of\n being broke."}
		};

		/// <summary>
		/// Searches through dictionary to find death reason.
		/// </summary> 
		public override void _Ready()
		{		
			_deathLabel = GetNode<Label>("Label4");
			_deathLabel.Text = "Reason: IDK why tbh.";

			foreach (KeyValuePair<Func<bool>, string> cond in _deathReasons)
			{
				if (cond.Key()) 
				{
					_deathLabel.Text = "Reason:\n " + cond.Value;
					break;
				}
			}
		}

		private void OnRestartPressed()
		{
			Utils.ResetGame();
		}
	}
}