import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/model/transaction_model.dart';
import 'package:flutter/material.dart';

class CardModel {
  final int number;
  final CardType type;
  final Currency currency;
  final double balance;
  final String holderName;
  final String expirationDate;
  final int cvc;
  final Color bgBeginColor;
  final Color bgEndColor;
  final List<TransactionModel> transactions;

  CardModel({
    this.number,
    this.type,
    this.currency,
    this.balance,
    this.holderName,
    this.expirationDate,
    this.cvc,
    this.bgBeginColor,
    this.bgEndColor,
    this.transactions,
  });
}