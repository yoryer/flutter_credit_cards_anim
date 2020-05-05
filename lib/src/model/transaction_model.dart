import 'package:credit_cards_animation/constants.dart';

class TransactionModel {
  final TransactionType type;
  final int quantity;
  final double amount;

  TransactionModel({
    this.type,
    this.quantity,
    this.amount,
  });
}