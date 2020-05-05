import 'dart:ui';
import 'dart:math' as math;

import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/model/card_model.dart';
import 'package:credit_cards_animation/src/repository/cards_repository.dart';
import 'package:credit_cards_animation/src/widgets/app_bar_widget.dart';
import 'package:credit_cards_animation/src/widgets/card_widget.dart';
import 'package:credit_cards_animation/src/widgets/transaction_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

enum CardsViewMode { SmallCard, SingleCard, CardsList }
enum CardScrollDirection { Up, Down }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final CardsRepository cardsRepository = CardsRepository();
  List<CardModel> cards = List<CardModel>();
  int selectedCardModelIndex = 0;
  int detailsCardModelIndex = 0;

  CardsViewMode viewMode = CardsViewMode.SingleCard;

  ScrollController cardScrollController = ScrollController();
  CardScrollDirection cardScrollDirection = CardScrollDirection.Down;
  double cardScrolledPixels = 0;

  double cardSideExtraPadding = 0;

  ScrollController txListScrollController = ScrollController();
  double txListScrolledPixels = 0;

  double labelOpacity = 1;
  double txListOpacity = 1;

  AnimationController appBarAnimationController;
  Animation appBarAnimation;
  bool appBarVisible = true;

  AnimationController cardDetailsAnimationController;
  Animation cardDetails1Animation;
  Animation cardDetails2Animation;

  ScrollController cardsListScrollController = ScrollController();
  double cardsListScrolledAmount = 0;

  @override
  void initState() {
    cards = cardsRepository.getCardsList();
    cardScrollController.addListener(cardScrollListener);
    txListScrollController.addListener(txListScrollListener);
    cardsListScrollController.addListener(cardsListScrollListener);

    appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    appBarAnimation = CurvedAnimation(
      parent: appBarAnimationController,
      curve: Curves.linear,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            appBarVisible = false;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            appBarVisible = true;
          });
        } else if (status == AnimationStatus.reverse) {
          setState(() {
            labelOpacity = appBarAnimation.value;
            txListOpacity = appBarAnimation.value;
            cardScrolledPixels = cardScrolledPixels * (1 - appBarAnimation.value);
          });
        }
      });

    cardDetailsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    cardDetails1Animation = CurvedAnimation(
      parent: cardDetailsAnimationController,
      curve: Interval(0.1, 0.8, curve: Curves.linear),
    );
    cardDetails2Animation = CurvedAnimation(
      parent: cardDetailsAnimationController,
      curve: Interval(0.1, 1.0, curve: Curves.linear),
    );

    super.initState();
  }

  void selectCardModel(int index) {
    setState(() {
      selectedCardModelIndex = index;
    });
  }

  void cardScrollListener() {
    if (cardScrollController.position.pixels > 0) {
      cardScrollDirection = CardScrollDirection.Up;
    }

    if (cardScrollDirection == CardScrollDirection.Down &&
        viewMode == CardsViewMode.SingleCard) {
      setState(() {
        cardScrolledPixels = cardScrollController.position.pixels.abs();
        labelOpacity = 1.0 - math.min(1, cardScrolledPixels / 100);
        txListOpacity = 1.0 - math.min(1, cardScrolledPixels / 130);

        if (labelOpacity < 0.9 && labelOpacity > 0.7) {
          cardSideExtraPadding = 36 * (1 - labelOpacity);
        } else if (labelOpacity < 0.1) {
          cardSideExtraPadding = 36 * labelOpacity;
        }

        if (cardScrolledPixels > 152) {
          viewMode = CardsViewMode.CardsList;
          cardScrollController.jumpTo(0);
          appBarAnimationController.forward();
          cardDetailsAnimationController.forward();
        }
      });
    }
  }

  void txListScrollListener() {
    if (txListScrollController.position.pixels > 0) {
      txListScrolledPixels = txListScrollController.position.pixels.abs();
    }
  }

  void cardsListScrollListener() {
    if (cardsListScrollController.position.pixels > 0) {
      setState(() {
        cardsListScrolledAmount =
            (cardsListScrollController.position.pixels.abs() / 100);
      });
      if (cardsListScrolledAmount >= 1) {
        if (selectedCardModelIndex < cards.length - 1) {
          setState(() {
            selectedCardModelIndex = selectedCardModelIndex + 1;
          });
          switchSelectedCardModelIndex();
          cardsListScrollController.jumpTo(0);
        }
      }
    } else {
      setState(() {
        cardsListScrolledAmount =
            -(cardsListScrollController.position.pixels.abs() / 100);
      });
      if (cardsListScrolledAmount <= -1) {
        if (selectedCardModelIndex > 0) {
          setState(() {
            selectedCardModelIndex = selectedCardModelIndex - 1;
          });
          switchSelectedCardModelIndex();
          cardsListScrollController.jumpTo(0);
        }
      }
    }
  }

  void switchSelectedCardModelIndex() async {
    await cardDetailsAnimationController.reverse();
    setState(() {
      detailsCardModelIndex = selectedCardModelIndex;
    });
    await cardDetailsAnimationController.forward();
  }

  void doneButtonFunction() {
    cardDetailsAnimationController.reverse();
    appBarAnimationController.reverse();

    setState(() {
      viewMode = CardsViewMode.SingleCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            cardDetailsView(
              cards[detailsCardModelIndex],
            ),
            cardView(
              cards[selectedCardModelIndex],
            ),
            transactionsList(cards[selectedCardModelIndex]),
            cardsList(),
            cardSwitcher(),
            AppBarWidget(
              appBarAnimation: appBarAnimation,
              labelOpacity: labelOpacity,
              doneButtonFunction: doneButtonFunction,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardView(CardModel cardModel) {
    return Container(
      height: double.infinity,
      padding:
          EdgeInsets.only(top: viewMode == CardsViewMode.CardsList ? 200 : 48),
      child: SingleChildScrollView(
        controller: cardScrollController,
        padding: EdgeInsets.zero,
        physics: viewMode == CardsViewMode.CardsList
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: cardSideExtraPadding),
              child: CardWidget(
                model: cardModel,
                displayShadows: true,
              ),
            ),
            Opacity(
              opacity: labelOpacity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    MaterialCommunityIcons.cellphone_wireless,
                    size: 16,
                    color: kGrayColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Hold your phone near the terminal',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: kGrayColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget transactionsList(CardModel cardModel) {
    return viewMode != CardsViewMode.CardsList
        ? Opacity(
            opacity: txListOpacity,
            child: Transform.translate(
              offset: Offset(0, cardScrolledPixels),
              child: Container(
                padding: EdgeInsets.only(top: 340),
                child: ListView.builder(
                  controller: txListScrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: cardModel.transactions.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'Transactions',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: kBlackColor,
                            fontSize: 20,
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      return SizedBox(
                        height: 8,
                      );
                    }

                    return Container(
                      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: TransactionRowWidget(
                        model: cardModel.transactions[index - 2],
                        currency: cardModel.currency,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        : SizedBox(
            width: 0,
            height: 0,
          );
  }

  Widget cardDetailsView(CardModel cardModel) {
    var numberFormat = NumberFormat('#,##0', 'en_US');
    String cardBalance = numberFormat.format(cardModel.balance);

    double screenSize = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.fromLTRB(
        56,
        80,
        56,
        8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedBuilder(
                animation: cardDetails1Animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      -screenSize + (screenSize * cardDetails1Animation.value),
                      0,
                    ),
                    child: child,
                  );
                },
                child: cardDetailItem(
                  cardBalance,
                  'USD',
                  'BALANCE',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              AnimatedBuilder(
                animation: cardDetails2Animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      -screenSize + (screenSize * cardDetails2Animation.value),
                      0,
                    ),
                    child: child,
                  );
                },
                child: cardDetailItem(
                  cardModel.holderName,
                  null,
                  'CARD HOLDER',
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedBuilder(
                animation: cardDetails1Animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      screenSize - (screenSize * cardDetails1Animation.value),
                      0,
                    ),
                    child: child,
                  );
                },
                child: cardDetailItem(
                  cardModel.expirationDate,
                  null,
                  'EXPIRES',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              AnimatedBuilder(
                animation: cardDetails2Animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      screenSize - (screenSize * cardDetails2Animation.value),
                      0,
                    ),
                    child: child,
                  );
                },
                child: cardDetailItem(
                  cardModel.cvc.toString(),
                  null,
                  'CVC',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardDetailItem(String value, String subValue, String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: kBlackColor,
                fontSize: 22,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            subValue != null
                ? Text(
                    subValue,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: kBlackColor,
                      fontSize: 12,
                    ),
                  )
                : SizedBox(
                    width: 0,
                  ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          description,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: kDarkPurpleColor.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget cardsList() {
    List<Widget> remainCards =
        List.generate(cards.length - (selectedCardModelIndex + 1), (index) {
      int position = cards.length - (index + 1);
      return cardListItem(position, cards[position]);
    });

    return viewMode == CardsViewMode.CardsList
        ? Container(
            padding: EdgeInsets.only(top: 370),
            child: Stack(
              children: remainCards,
            ),
          )
        : SizedBox(
            width: 0,
            height: 0,
          );
  }

  Widget cardListItem(int position, CardModel cardModel) {
    double cardOpacity =
        math.max(0, 1 - ((position - 1 - selectedCardModelIndex) * 0.4));
    double yOffset = 16.0 * (position + 1) -
        ((selectedCardModelIndex * cardsListScrolledAmount) * 16.0);
    double rotate = math.pi * -0.22;

    /// Selecting next card
    if (position == selectedCardModelIndex + 1 && cardsListScrolledAmount > 0) {
      yOffset = yOffset - (200 * cardsListScrolledAmount);
      rotate = rotate + (0.22 * cardsListScrolledAmount);
    }

    return Opacity(
      opacity: cardOpacity,
      child: Transform.translate(
        offset: Offset(0, yOffset),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..scaled(1.0, 1.0, 1.8)
            ..rotateX(rotate)
            ..rotateY(0.0)
            ..rotateZ(0.0),
          child: CardWidget(
            model: cardModel,
            displayShadows: false,
          ),
          alignment: FractionalOffset.center,
        ),
      ),
    );
  }

  Widget cardSwitcher() {
    return viewMode == CardsViewMode.CardsList
        ? SingleChildScrollView(
            controller: cardsListScrollController,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.only(top: 220),
              width: double.infinity,
              height: 430,
            ),
          )
        : SizedBox(
            width: 0,
            height: 0,
          );
  }
}
