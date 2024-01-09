import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instawish/components/post.dart';
import 'package:instawish/components/user_avatar.dart';
import 'package:instawish/utils/api.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({Key? key}) : super(key: key);

@override
State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

    Future<dynamic> getPost() async {
      var token = await Api().getToken();
      var data = await Api().getData(token);
      var post = jsonDecode(data);     

      return post;
    }

    Future<dynamic> getUsers() async {
      var token = await Api().getToken();
      var data = await Api().getUsers(token);
      var users = jsonDecode(data);     

      return users;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder(
        future: Future.wait([getPost(), getUsers()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que les données sont récupérées
            return Center(child: CircularProgressIndicator());
            
          } else if (snapshot.hasError) {
            // Afficher un message d'erreur si une erreur s'est produite lors de la récupération des données
            return Center(child: Text('Une erreur s\'est produite.'));
            
          } else {
            // Utiliser les données récupérées dans le Scaffold
            var post = snapshot.data[0];
            var users = snapshot.data[1].values;
            // print(post);
            // print(users["username"]);
            return Column(
              children: [
                //////// stories /////////
                Container(
                  height: 120,
                  decoration: BoxDecoration(color: Colors.grey),
                  margin: EdgeInsets.only(top: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var user in users) 
                        Column(
                          children: [
                            UserAvatar(userAvatar: "avatar_deux.jpg", bg: true),
                            Text(
                              user["username"],
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
                      for (var i = 0; i < post.length; i++)
                        Column(
                          children: [
                            Post(
                              username: post[i]["createdBy"]["username"],
                              // userAvatar: post[i]["createdBy"]["imageUrl"],
                              postDescription: post[i]["description"],
                              postImage: post[i]["imageUrl"],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
