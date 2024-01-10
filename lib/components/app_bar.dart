import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instawish/utils/api.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

    Future<dynamic> getMe() async {
    var token = await Api().getToken();
    var data = await Api().getMe(token);
    var selfData = jsonDecode(data);     

    return selfData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMe(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            title: Text("Loading..."),
          );
        } else if (snapshot.hasError) {
          return AppBar(
            title: Text("Error"),
          );
        } else {
          var selfAvatar = snapshot.data["imageUrl"];
          return AppBar(
            title: GestureDetector(
              onTap: () {
                context.go('/');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "InstaWish",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.cyan[300],
            leading: GestureDetector(
              onTap: () {
                context.go('/createpost');
              },
              child: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://symfony-instawish.formaterz.fr$selfAvatar",
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    iconSize: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {
                    context.go('/profil');
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
