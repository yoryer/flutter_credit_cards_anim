import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

Color kWhiteColor = Color(0xffffffff);
Color kSnowColor = Color(0xffd9dae4);
Color kBlackColor = Color(0xff100d0b);
Color kDarkPurpleColor = Color(0xff0a0759);
Color kLightPurpleColor = Color(0xff685283);
Color kDarkGrayColor = Color(0xff5a555f);
Color kGrayColor = Color(0xffa0a0a9);
Color kLightGrayColor = Color(0xffd9dae4);
Color kBlueColor = Color(0xff0a0759);
Color kOrangeColor = Color(0xfff6391f);
Color kLavenderColor = Color(0xffc6bbcc);

enum CardType {
  Visa,
  Maestro
}

enum Currency {
  Dollar,
  Euro,
  BritishPound
}

enum TransactionType {
  Shopping,
  Entertainment,
  Commuting,
  FoodDrinks,
  Gym,
  Grocery,
}

String getCurrencyStringSymbol(Currency currency) {
  switch (currency) {
    case Currency.Euro:
      return '€';
      break;
    case Currency.BritishPound:
      return '£';
      break;
    default:
      return '\$';
  }
}

IconData getTransactionTypeIcon(TransactionType transactionType) {
  switch (transactionType) {
    case TransactionType.Shopping:
      return FontAwesome5Solid.shopping_bag;
      break;
    case TransactionType.Entertainment:
      return FontAwesome5Solid.headphones;
      break;
    case TransactionType.Commuting:
      return FontAwesome5Solid.car;
      break;
    case TransactionType.FoodDrinks:
      return FontAwesome5Solid.cheese;
      break;
    case TransactionType.Grocery:
      return FontAwesome5Solid.store;
      break;
    case TransactionType.Gym:
      return FontAwesome5Solid.dumbbell;
      break;
    default:
      return FontAwesome5Solid.credit_card;
  }
}

Color getTransactionTypeColor(TransactionType transactionType) {
  switch (transactionType) {
    case TransactionType.Shopping:
      return Color(0xff3492E2);
      break;
    case TransactionType.Entertainment:
      return Color(0xff4C42A8);
      break;
    case TransactionType.Commuting:
      return Color(0xffB860C2);
      break;
    case TransactionType.FoodDrinks:
      return Color(0xffD96756);
      break;
    case TransactionType.Grocery:
      return Color(0xff5B806F);
      break;
    case TransactionType.Gym:
      return Color(0xffBA804C);
      break;
    default:
      return Color(0xff5A595C);
  }
}

String getTransactionTypeTitle(TransactionType transactionType) {
  switch (transactionType) {
    case TransactionType.Shopping:
      return 'Shopping';
      break;
    case TransactionType.Entertainment:
      return 'Entertainment';
      break;
    case TransactionType.Commuting:
      return 'Transport';
      break;
    case TransactionType.FoodDrinks:
      return 'Food & Drinks';
      break;
    case TransactionType.Grocery:
      return 'Grocery';
      break;
    case TransactionType.Gym:
      return 'Gym';
      break;
    default:
      return 'Others';
  }
}