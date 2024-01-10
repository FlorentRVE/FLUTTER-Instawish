import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
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

  getData(token) async {

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
}
