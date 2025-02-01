using Godot;
using System;

public partial class ShopItem : Control
{    
    [Export] public Texture2D Texture { get; private set; }
    [Export] public int FoodBuff { get; private set; }
    [Export] public int HealthBuff { get; private set; }
    [Export] public int FunBuff { get; private set; }
    [Export] public int Cost { get; private set; }

    public Action<ShopItem> PurchaseEvent;

    private TextureRect _texture;
    private Button _purchaseButton;


    public override void _Ready()
    {
        _texture = GetNode<TextureRect>("HBoxContainer/Background/Icon");
        _texture.Texture = Texture;

        _purchaseButton = GetNode<Button>("HBoxContainer/PurchaseButton");
        _purchaseButton.Text = "Buy: $" + Cost + "\n";

        _purchaseButton.Text += FoodBuff != 0 ? $"+{FoodBuff} Food " : "";
        _purchaseButton.Text += HealthBuff != 0 ? $"{HealthBuff} Health\n" : " ";
        _purchaseButton.Text += FunBuff != 0 ? $"{FunBuff} Fun " : "";
    }

    private void OnPurchaseButtonPressed()
    {
        PurchaseEvent?.Invoke(this);
    }


    /// <summary>
    /// Apply costs and buffs to Goober stats, if player has enough coins
    /// </summary>
    public void ApplyBuffs()
    {
        GameManager.Coins -= Cost;

        GameManager.Health += HealthBuff;
        GameManager.Fun += FunBuff;
        GameManager.Food += FoodBuff;
    }
}
