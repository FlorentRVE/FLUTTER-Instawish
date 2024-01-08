
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.userAvatar,
    required this.bg,
  });

  final String userAvatar;
  final bool bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: bg ? Border.all(
          color: Colors.red,
          width: 4,
        )
            : null
            ,
      ) ,
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/$userAvatar"),
        radius: 35,
      ),
    );
  }
}
