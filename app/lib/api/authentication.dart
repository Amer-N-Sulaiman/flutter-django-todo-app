import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session/flutter_session.dart';


class AuthProvider extends ChangeNotifier{
  // final storage = new FlutterSecureStorage();
  bool authStatus = false;
  String base_url = '192.168.43.112:8000';
  User user;
  


  void signup(String email, String username, String password, String password2) async{
    User user = User(email: email, username: username, password: password, password2: password2);
    final response = await http.post(Uri.http(base_url, 'account/registeration/'),
        headers: {"Content-Type": "application/json"}, body: json.encode(user));
    if (response.statusCode == 200) {
      var token = json.decode(response.body)['token'];
      // await storage.write(key: 'AuthToken', value: token);
      this.user = User(email:email, username:username, password:null, password2:null);
      
      await FlutterSession().set('token', token);
      await FlutterSession().set('email', email);
      await FlutterSession().set('username', username);

      notifyListeners();
    }
    authStatus = true;
  }

  void login(String email, String password) async{
    Map data = {};
    data['username'] = email;
    data['password'] = password;

    final response = await http.post(Uri.http(base_url, 'account/login/'),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    var token;
    if (response.statusCode == 200){
      token = json.decode(response.body)['token'];
      final userInfoResponse = await http.get(Uri.http(base_url, 'account/currentUserinfo/'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token $token',
      });
      if(response.statusCode == 200){
        var username = json.decode(userInfoResponse.body)['username'];
        await FlutterSession().set('email', email);
        await FlutterSession().set('username', username);
      }else{
        print('error2');
      }
      
    } else{
      print('error');
    }
    // await storage.write(key: 'AuthToken', value: token);
    await FlutterSession().set('token', token);
    authStatus = true;
  }

  void logout() async{
    FlutterSession().set('token', json.encode(null));
    authStatus = false;
  }
}