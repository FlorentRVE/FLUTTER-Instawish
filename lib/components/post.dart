import 'package:flutter/material.dart';
import 'package:instawish/components/user_avatar.dart';

class Post extends StatelessWidget {
  final String username;
  // final String userAvatar;
  final String postDescription;
  final String postImage;

  const Post({
    Key? key,
    required this.username,
    // required this.userAvatar,
    required this.postDescription,
    required this.postImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          // entête du post
          Container(
            decoration: BoxDecoration(color: Colors.red),
            child: SizedBox(
              width: 400,
              height: 100,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 20, left: 60),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 15,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(username),
                  ),
                ),
                Positioned(
                  left: -10,
                  child: UserAvatar(userAvatar: "avatar_deux.jpg", bg: true),
                ),
                Positioned(
                  top: 25,
                  right: 5,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 35,
                  ),
                )
              ]),
            ),
          ),
          // image
          Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Image.network("https://symfony-instawish.formaterz.fr$postImage"),
          ),
          // description
          Container(
            height: 30,
            width: 400,
            decoration: BoxDecoration(color: Colors.yellow),
            child: Center(
              child: Text(
                postDescription,
              ),
            ),
          ),
          // boutton d'interaction
          Container(
            height: 70,
            width: 400,
            decoration: BoxDecoration(color: Colors.green),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  padding:
                      EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 30,
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Like et date du post
          Container(
            height: 30,
            width: 400,
            decoration: BoxDecoration(color: Colors.orange),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("310 likes", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      Text(
                        "11 minutes ago",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
