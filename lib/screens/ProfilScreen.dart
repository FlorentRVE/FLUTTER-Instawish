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

    Future<dynamic> getUserPost(id) async {
      var token = await Api().getToken();
      
      var userPost = await Api().getUserPost(token, id);
      var post = jsonDecode(userPost);     

      return post;
    }

    Future<dynamic> getFollowings(id) async {
      var token = await Api().getToken();

      var followings = await Api().getFollowing(token, id);
      var followingsData = jsonDecode(followings);

      return followingsData;
    }

    Future<dynamic> getFollowers(id) async {
      var token = await Api().getToken();

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

    Future<dynamic> getUser(id) async {
      var token = await Api().getToken();
      var data = await Api().getUser(token, id);
      var me = jsonDecode(data);     

      return me;
    }

  @override
  Widget build(BuildContext context) {
    var params = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    var id = params?["id"];    

    return Scaffold(
      //////////// AppBar //////////////////
      appBar: MyAppBar(),

      //////////// Body //////////////////
      body: FutureBuilder(
        future: Future.wait([checkToken(), getUserPost(id), getUsers(), getUser(id), getFollowings(id), getFollowers(id)]),
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
                  height: 130,
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 50, top: 15),
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
                      GestureDetector(
                        onTap: () async {
                          var token = await Api().getToken();
                          Api().follow(token, profil["id"]);
                          print(profil["username"] + " followed");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Follow",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
                              ),
                            ],
                          ),
                          
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


