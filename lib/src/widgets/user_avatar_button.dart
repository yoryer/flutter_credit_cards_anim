import 'package:credit_cards_animation/constants.dart';
import 'package:flutter/material.dart';

class UserAvatarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24),
      padding: EdgeInsets.all(2),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: kDarkPurpleColor.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset('assets/images/avatar_photo.jpg'),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
