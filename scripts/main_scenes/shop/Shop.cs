using Godot;
using System;

public partial class Shop : Control
{
    private GridContainer _shopGrid;
    private Label _coinsLabel;
    private Node2D _speechBubble;
    private AnimationPlayer _speechAnimPlayer;
    private Label _speechText;
    private Timer _speechTimer;


    public override void _Ready()
    {
        _shopGrid = GetNode<GridContainer>("ShopContainer/ShopItems");
        _coinsLabel = GetNode<Label>("CoinContainer/CoinsText");

        _speechBubble = GetNode<Node2D>("SpeechBubble");
        _speechText = GetNode<Label>("SpeechBubble/SpeechText");
        _speechTimer = GetNode<Timer>("SpeechBubble/SpeechTimer");
        _speechAnimPlayer = GetNode<AnimationPlayer>("SpeechBubble/SpeechAnimPlayer");

        foreach (Node node in _shopGrid.GetChildren()) 
        {
            if (node is ShopItem itemNode) 
            { 
                itemNode.PurchaseEvent += HandlePurchase;
            }
        }

        _speechAnimPlayer.Play("Fade In");
    }

    private void HandlePurchase(ShopItem item)
    {
        _speechAnimPlayer.Play("Fade In");

        if (GameManager.Coins >= item.Cost)
        {
            item.ApplyBuffs();
            _coinsLabel.Text = Convert.ToString(GameManager.Coins);
            _speechText.Text = "Thanks for purchasing!";
        } else {
            _speechText.Text = "You're too poor!";
        }

        _speechBubble.Visible = true;
        _speechTimer.Start();
    }

    private void OnSpeechTimerTimeout()
    {
        _speechAnimPlayer.PlayBackwards("Fade In");
    }

    private void OnBackButtonPressed()
    {
        SceneManager.Instance.SwitchScene("res://scenes/main_scenes/main.tscn");
    }
}
