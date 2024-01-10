import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instawish/components/app_bar.dart';
import 'package:instawish/components/post.dart';
import 'package:instawish/components/user_avatar.dart';
import 'package:instawish/utils/api.dart';

class ProfilScreen extends StatefulWidget {
const ProfilScreen({Key? key}) : super(key: key);

@override
State<ProfilScreen> createState() => ProfilScreenState();
}

class ProfilScreenState extends State<ProfilScreen> {

    Future<dynamic> checkToken() async {

      var token = await Api().getToken();

      if (token == null) {

        Future.delayed(const Duration(seconds: 1), () {

          context.go('/login');

        });
      }

    }

    Future<dynamic> getUserPost() async {
      var token = await Api().getToken();
      var data = await Api().getMe(token);

      var id = jsonDecode(data)['id'];
      
      var userPost = await Api().getUserPost(token, id);
      var post = jsonDecode(userPost);     

      return post;
    }

    Future<dynamic> getFollowings() async {
      var token = await Api().getToken();
      var data = await Api().getMe(token);

      var id = jsonDecode(data)['id'];

      var followings = await Api().getFollowing(token, id);
      var followingsData = jsonDecode(followings);

      return followingsData;
    }

    Future<dynamic> getFollowers() async {
      var token = await Api().getToken();
      var data = await Api().getMe(token);

      var id = jsonDecode(data)['id'];

      var followers = await Api().getFollowers(token, id);
      var followersData = jsonDecode(followers);

      return followersData;
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
        future: Future.wait([checkToken(), getUserPost(), getUsers(), getMe(), getFollowings(), getFollowers()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que les données sont récupérées
            return Center(child: CircularProgressIndicator());
            
          } else if (snapshot.hasError) {
            // Afficher un message d'erreur si une erreur s'est produite lors de la récupération des données
            return Center(child: Text('Erreur login'));
            
          } else {
            // Utiliser les données récupérées dans le Scaffold
            var userPost = snapshot.data[1];
            var profil = snapshot.data[3];
            var followings = snapshot.data[4];
            var followers = snapshot.data[5];
            return Column(
              children: [
                //////// Profil info /////////
                Container(
                  height: 150,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 80, top: 25),
                        child: Column(
                          children: [
                            UserAvatar(userAvatar: profil["imageUrl"], bg: false),
                            Text(
                              profil["username"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              followers["followers"].length.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(" followers"),
                          ],
                        ),
                
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              followings["followings"].length.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(" following"),
                          ],
                        ),
                
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
                      for (var i = 0; i < userPost.length; i++)
                        Column(
                          children: [
                            Post(
                              username: userPost[i]["createdBy"]["username"],
                              userAvatar: userPost[i]["createdBy"]["imageUrl"],
                              postDescription: userPost[i]["description"],
                              postImage: userPost[i]["imageUrl"],
                              postLike: userPost[i]["likeds"].length.toString(),
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


