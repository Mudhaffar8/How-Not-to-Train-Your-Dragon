using Godot;
using System;
using System.Collections.Generic;
using System.Linq;

namespace TrainYourDragon.Minigames.BlackJack
{
    public class CardHand
    {
        public string CardHolderName { get; init; }
        public int Score { get; private set; } = 0;
        public List<Card> Cards { get; private set; } = new(10);

        public CardHand(string name)
        {
            CardHolderName = name;
        }

        public void ReleaseAllCards()
        {
            Score = 0;
            Cards.Clear();
        }

        public void AddCard(Card card)
        {
            Cards.Add(card);
            Score = Cards.Sum(card => Math.Clamp((int)card.Value, 0, (int)CardValues.TEN));
        }

        public void PrintDeck()
        {
            GD.Print(CardHolderName);
            GD.Print(string.Join(", ", Cards));
			GD.Print(Score);
            GD.Print("");
        }
    }
}