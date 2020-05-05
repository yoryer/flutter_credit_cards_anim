import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  final CardModel model;
  final bool displayShadows;

  CardWidget({
    this.model,
    this.displayShadows,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        displayShadows
            ? cardShadow(64, 16)
            : SizedBox(
                width: 0,
                height: 0,
              ),
        displayShadows
            ? cardShadow(56, 8)
            : SizedBox(
                width: 0,
                height: 0,
              ),
        cardFront(),
      ],
    );
  }

  Widget cardFront() {
    String cardNumber = model.number.toString();
    cardNumber = cardNumber.substring(0, 4) +
        '  ' +
        cardNumber.substring(4, 8) +
        '  ' +
        cardNumber.substring(8, 12) +
        '  ' +
        cardNumber.substring(12);

    var numberFormat = NumberFormat('#,##0', 'en_US');
    String cardBalance = numberFormat.format(model.balance);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
      margin: EdgeInsets.fromLTRB(48, 24, 48, 24),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            model.bgBeginColor,
            model.bgEndColor,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: model.bgEndColor,
            blurRadius: 0,
            offset: displayShadows ? Offset.zero : Offset(1, 3),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: displayShadows ? 8 : 0,
            offset: displayShadows ? Offset(0, 16) : Offset.zero,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Transform.rotate(
                angle: (3 * math.pi) / 2,
                child: Icon(
                  MaterialCommunityIcons.sim,
                  color: kWhiteColor.withOpacity(0.8),
                  size: 32,
                ),
              ),
              Image.asset(
                model.type == CardType.Visa
                    ? 'assets/images/cc_visa_logo.png'
                    : 'assets/images/cc_maestro_logo.png',
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 0,
            ),
          ),
          Text(
            cardNumber,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: kWhiteColor,
              letterSpacing: 3,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: Text(
              '${getCurrencyStringSymbol(model.currency)} $cardBalance',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: kWhiteColor,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardShadow(double sideMargin, double topOffset) {
    return Transform.translate(
      offset: Offset(0, topOffset),
      child: Container(
        margin: EdgeInsets.fromLTRB(sideMargin, 24, sideMargin, 24),
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: kLightGrayColor,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
    );
  }
}
