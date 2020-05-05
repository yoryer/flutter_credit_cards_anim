import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/model/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionRowWidget extends StatelessWidget {
  final TransactionModel model;
  final Currency currency;

  TransactionRowWidget({
    this.model,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    String transactionsSubtitle = model.quantity == 1
        ? '1 transaction'
        : '${model.quantity} transactions';

    return Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: getTransactionTypeColor(model.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            getTransactionTypeIcon(model.type),
            size: 20,
            color: getTransactionTypeColor(model.type),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                getTransactionTypeTitle(model.type),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  color: kBlackColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                transactionsSubtitle,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: kGrayColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${getCurrencyStringSymbol(currency)} ${model.amount}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: kDarkPurpleColor.withOpacity(0.7),
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
