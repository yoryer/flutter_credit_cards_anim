import 'package:credit_cards_animation/constants.dart';
import 'package:credit_cards_animation/src/widgets/menu_icon_button.dart';
import 'package:credit_cards_animation/src/widgets/user_avatar_button.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  final Animation appBarAnimation;
  final double labelOpacity;
  final Function doneButtonFunction;

  AppBarWidget({
    this.appBarAnimation,
    this.labelOpacity,
    this.doneButtonFunction,
  });

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              AnimatedBuilder(
                animation: widget.appBarAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0 - (64 * widget.appBarAnimation.value), 0),
                    child: Opacity(
                      opacity: 1 - widget.appBarAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: MenuIconButton(),
              ),
              AnimatedBuilder(
                animation: widget.appBarAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset:
                        Offset(-64 + (64 * widget.appBarAnimation.value), 0),
                    child: Opacity(
                      opacity: widget.appBarAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    print('Done');
                    widget.doneButtonFunction();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: kDarkPurpleColor.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Opacity(
                opacity: widget.labelOpacity,
                child: Text(
                  'My Account',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                    fontSize: 22,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: widget.appBarAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: widget.appBarAnimation.value,
                    child: child,
                  );
                },
                child: Text(
                  'Bank Cards',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: kBlackColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              AnimatedBuilder(
                animation: widget.appBarAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0 + (64 * widget.appBarAnimation.value), 0),
                    child: Opacity(
                      opacity: 1 - widget.appBarAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: UserAvatarButton(),
              ),
              AnimatedBuilder(
                animation: widget.appBarAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(64 - (64 * widget.appBarAnimation.value), 0),
                    child: Opacity(
                      opacity: widget.appBarAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: kDarkPurpleColor.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
