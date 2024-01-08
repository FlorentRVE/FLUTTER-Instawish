import 'package:flutter/material.dart';
import 'package:instawish/components/post.dart';
import 'package:instawish/components/user_avatar.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Enlèver la banniere debug

      /////////////// Contenu //////////////////
      home: Scaffold(
        //////////// AppBar //////////////////
        appBar: AppBar(
            title: Row(
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
            backgroundColor: Colors.cyan[300],
            leading: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.jpg"),
                ),
              ),
            ]),

        //////////// Body //////////////////
        body: Column(
          children: [
            //////// stories /////////
            Container(
              height: 120,
              decoration: BoxDecoration(color: Colors.grey),
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < 25; i++)
                    Column(
                      children: [
                        UserAvatar(userAvatar: "avatar_deux.jpg", bg: true),
                        Text(
                          "Avatar $i",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                ],
              ),
            ),

            //////// posts /////////
            Container(
              height: 500,
              decoration: BoxDecoration(color: Color.fromARGB(255, 28, 210, 243)),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  for (var i = 0; i < 25; i++)
                    Column(
                      children: [
                        Post(),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

