import 'package:credit_cards_animation/constants.dart';
import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24),
      width: 24,
      height: 24,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: List.generate(4, (index) => dotWidget()),
      ),
    );
  }

  Widget dotWidget() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: kDarkPurpleColor.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}
