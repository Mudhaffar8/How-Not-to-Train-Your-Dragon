using Godot;
using System;

/// <summary>
/// Manages/handles shop transactions and other miscellenous things.
/// </summary> 
namespace TrainYourDragon.MainScenes.Shop
{
    public partial class ShopManager : Control
    {
        private GridContainer _shopGrid;
        private Label _coinsLabel;

        private AnimationPlayer _speechAnimPlayer;
        private Label _speechText;
        private Timer _speechTimer;

        private Label _transactionText;
        private AnimationPlayer _transactionAnimPlayer;


        public override void _Ready()
        {
            _shopGrid = GetNode<GridContainer>("ShopContainer/ShopItems");
            _coinsLabel = GetNode<Label>("CoinContainer/CoinsText");

            _speechText = GetNode<Label>("SpeechBubble/SpeechText");
            _speechTimer = GetNode<Timer>("SpeechBubble/SpeechTimer");
            _speechAnimPlayer = GetNode<AnimationPlayer>("SpeechBubble/SpeechAnimPlayer");

            _transactionText = GetNode<Label>("TransactionPopup/PopupText");
            _transactionAnimPlayer = GetNode<AnimationPlayer>("TransactionPopup/AnimationPlayer");

            foreach (Node node in _shopGrid.GetChildren()) 
            {
                if (node is ShopItem itemNode) 
                { 
                    itemNode.PurchaseEvent += HandlePurchase;
                }
            }

            _speechAnimPlayer.Play("Fade");
            _speechTimer.Start();

            _coinsLabel.Text = Convert.ToString(GameManager.Coins);
        }

        private void HandlePurchase(ShopItem item)
        {
            if (GameManager.Coins >= item.Cost)
            {
                item.ApplyBuffs();

                _transactionText.Text = $"-{item.Cost}";
                _transactionAnimPlayer.Play("Fade");

                _coinsLabel.Text = Convert.ToString(GameManager.Coins);
                _speechText.Text = "Thanks for purchasing!";
            } else {
                _speechText.Text = "You're too poor!";
            }

            // Play Speech Bubble Animation
            _speechAnimPlayer.Play("Fade");
            _speechTimer.Start();
        }

        private void OnSpeechTimerTimeout()
        {
            _speechAnimPlayer.PlayBackwards("Fade");
        }

        private void OnBackButtonPressed()
        {
            SceneManager.Instance.SwitchScene(GameScenes.MAIN_HUB);
        }
    }
}