import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instawish/components/app_bar.dart';
import 'package:instawish/components/post.dart';
import 'package:instawish/components/user_avatar.dart';
import 'package:instawish/utils/api.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({Key? key}) : super(key: key);

@override
State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

    Future<dynamic> checkToken() async {

      var token = await Api().getToken();

      if (token == null) {

        Future.delayed(const Duration(seconds: 1), () {

          context.go('/login');

        });
      }

    }

    Future<dynamic> getPosts() async {
      var token = await Api().getToken();
      var data = await Api().getPosts(token);
      var post = jsonDecode(data);     

      return post;
    }

    Future<dynamic> getUsers() async {
      var token = await Api().getToken();
      var data = await Api().getUsers(token);
      var users = jsonDecode(data);     

      return users;
    }

    Future<dynamic> getMe() async {
      var token = await Api().getToken();
      var data = await Api().getMe(token);
      var me = jsonDecode(data);     

      return me;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //////////// AppBar //////////////////
      appBar: MyAppBar(),

      //////////// Body //////////////////
      body: FutureBuilder(
        future: Future.wait([checkToken(), getPosts(), getUsers(), getMe()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que les données sont récupérées
            return Center(child: CircularProgressIndicator());
            
          } else if (snapshot.hasError) {
            // Afficher un message d'erreur si une erreur s'est produite lors de la récupération des données
            return Center(child: Text('Erreur login'));
            
          } else {
            // Utiliser les données récupérées dans le Scaffold
            var post = snapshot.data[1];
            var users = snapshot.data[2].values;
            // var me = snapshot.data[3];
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
                            UserAvatar(userAvatar: user["imageUrl"], bg: true),
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
                              userAvatar: post[i]["createdBy"]["imageUrl"],
                              postDescription: post[i]["description"],
                              postImage: post[i]["imageUrl"],
                              postLike: post[i]["likeds"].length.toString(),
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


