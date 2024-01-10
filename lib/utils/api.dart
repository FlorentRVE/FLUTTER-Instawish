import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  login(data) async {

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/login_check');

    var body = data;

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {

      return(resBody);

    } else {

      return(res.reasonPhrase);
    }

  }

  createPost(token, data) async {

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization':
          'Bearer $token'
    };

    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/post/add');

    var body = data['description'];

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.files.add(await http.MultipartFile.fromPath('picture', data['picture']));
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    }
    else {
      return(res.reasonPhrase);
    }
  }

  getPosts(token) async {

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization':
          'Bearer $token'
    };
    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/home');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    } else {
      return(res.reasonPhrase);
    }
  }

  getUserPost(token, id) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/home/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return (resBody);
    } else {
      return (res.reasonPhrase);
    }
  }

  getFollowing(token, id) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        'https://symfony-instawish.formaterz.fr/api/follow/followings/$id');


    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    } else {
      return(res.reasonPhrase);
    }
  }

  getFollowers(token, id) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        'https://symfony-instawish.formaterz.fr/api/follow/followers/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return (resBody);
    } else {
      return (res.reasonPhrase);
    }
  }

  getUsers(token) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/users');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    } else {
      return(res.reasonPhrase);
    }
  }

  getMe(token) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/me');


    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    } else {
      return(res.reasonPhrase);
    }
  }

  getUser(token, id) async {
      var headersList = {
        'Accept': '*/*',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
        'Authorization': 'Bearer $token'
      };
      var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/user/$id');


      var req = http.Request('GET', url);
      req.headers.addAll(headersList);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return (resBody);
      } else {
        return (res.reasonPhrase);
      }
  }

  follow(token, id) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://symfony-instawish.formaterz.fr/api/follow/add/$id');

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return(resBody);
    }
    else {
      return(res.reasonPhrase);
    }
      }
}
