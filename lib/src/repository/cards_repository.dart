import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/model/card_model.dart';
import 'package:credit_cards_animation/src/model/transaction_model.dart';
import 'package:flutter/material.dart';

class CardsRepository {
  List<CardModel> getCardsList() {
    List<TransactionModel> card1Transactions = [
      TransactionModel(
        type: TransactionType.Shopping,
        quantity: 2,
        amount: 232.76,
      ),
      TransactionModel(
        type: TransactionType.Entertainment,
        quantity: 3,
        amount: 49.43,
      ),
      TransactionModel(
        type: TransactionType.Commuting,
        quantity: 11,
        amount: 58.53,
      ),
      TransactionModel(
        type: TransactionType.FoodDrinks,
        quantity: 6,
        amount: 67.47,
      ),
      TransactionModel(
        type: TransactionType.Gym,
        quantity: 3,
        amount: 123.43,
      ),
      TransactionModel(
        type: TransactionType.Grocery,
        quantity: 1,
        amount: 33.43,
      ),
      TransactionModel(
        type: TransactionType.Shopping,
        quantity: 2,
        amount: 232.76,
      ),
      TransactionModel(
        type: TransactionType.Entertainment,
        quantity: 3,
        amount: 49.43,
      ),
      TransactionModel(
        type: TransactionType.Commuting,
        quantity: 11,
        amount: 58.53,
      ),
      TransactionModel(
        type: TransactionType.FoodDrinks,
        quantity: 6,
        amount: 67.47,
      ),
      TransactionModel(
        type: TransactionType.Gym,
        quantity: 3,
        amount: 123.43,
      ),
      TransactionModel(
        type: TransactionType.Grocery,
        quantity: 1,
        amount: 33.43,
      ),
    ];

    List<TransactionModel> card2Transactions = [
      TransactionModel(
        type: TransactionType.Shopping,
        quantity: 1,
        amount: 22.76,
      ),
      TransactionModel(
        type: TransactionType.Entertainment,
        quantity: 1,
        amount: 22.20,
      ),
      TransactionModel(
        type: TransactionType.Gym,
        quantity: 3,
        amount: 89.23,
      ),
      TransactionModel(
        type: TransactionType.Grocery,
        quantity: 1,
        amount: 41.41,
      ),
      TransactionModel(
        type: TransactionType.Shopping,
        quantity: 1,
        amount: 22.76,
      ),
      TransactionModel(
        type: TransactionType.Entertainment,
        quantity: 1,
        amount: 22.20,
      ),
      TransactionModel(
        type: TransactionType.Gym,
        quantity: 3,
        amount: 89.23,
      ),
      TransactionModel(
        type: TransactionType.Grocery,
        quantity: 1,
        amount: 41.41,
      ),
    ];

    List<TransactionModel> card3Transactions = [
      TransactionModel(
        type: TransactionType.Shopping,
        quantity: 7,
        amount: 822.36,
      ),
      TransactionModel(
        type: TransactionType.Entertainment,
        quantity: 2,
        amount: 98.43,
      ),
      TransactionModel(
        type: TransactionType.Commuting,
        quantity: 33,
        amount: 123.53,
      ),
      TransactionModel(
        type: TransactionType.FoodDrinks,
        quantity: 3,
        amount: 11.47,
      ),
      TransactionModel(
        type: TransactionType.Gym,
        quantity: 3,
        amount: 44.43,
      ),
      TransactionModel(
        type: TransactionType.Grocery,
        quantity: 13,
        amount: 78.43,
      ),
    ];

    return [
      CardModel(
        number: 1510645983016543,
        type: CardType.Visa,
        currency: Currency.Dollar,
        balance: 1200,
        holderName: 'Allison Jackson',
        expirationDate: '03/21',
        cvc: 359,
        bgBeginColor: Colors.purpleAccent,
        bgEndColor: Colors.deepPurple,
        transactions: card1Transactions,
      ),
      CardModel(
        number: 2695295847963685,
        type: CardType.Maestro,
        currency: Currency.BritishPound,
        balance: 4898,
        holderName: 'Aubrey Zimmerman',
        expirationDate: '10/28',
        cvc: 539,
        bgBeginColor: Colors.orangeAccent,
        bgEndColor: Colors.deepOrangeAccent,
        transactions: card2Transactions,
      ),
      CardModel(
        number: 3313059647096860,
        type: CardType.Maestro,
        currency: Currency.Euro,
        balance: 980,
        holderName: 'Daniella Orr',
        expirationDate: '02/27',
        cvc: 471,
        bgBeginColor: Colors.blueAccent,
        bgEndColor: Colors.blueGrey,
        transactions: card3Transactions,
      ),
      CardModel(
        number: 4510645983016543,
        type: CardType.Visa,
        currency: Currency.Dollar,
        balance: 1200,
        holderName: 'Allison Jackson',
        expirationDate: '03/21',
        cvc: 359,
        bgBeginColor: Colors.redAccent,
        bgEndColor: Colors.red,
        transactions: card1Transactions,
      ),
      CardModel(
        number: 5695295847963685,
        type: CardType.Maestro,
        currency: Currency.BritishPound,
        balance: 4898,
        holderName: 'Aubrey Zimmerman',
        expirationDate: '10/28',
        cvc: 539,
        bgBeginColor: Colors.indigoAccent,
        bgEndColor: Colors.indigo,
        transactions: card2Transactions,
      ),
      CardModel(
        number: 6313059647096860,
        type: CardType.Maestro,
        currency: Currency.Euro,
        balance: 980,
        holderName: 'Daniella Orr',
        expirationDate: '02/27',
        cvc: 471,
        bgBeginColor: Colors.greenAccent,
        bgEndColor: Colors.green,
        transactions: card3Transactions,
      ),
    ];
  }
}
