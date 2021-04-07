import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_session/flutter_session.dart';


class AuthProvider extends ChangeNotifier{
  // final storage = new FlutterSecureStorage();


  void signup(String email, String username, String password, String password2) async{
    User user = User(email: email, username: username, password: password, password2: password2);
    final response = await http.post(Uri.http('192.168.43.112:8000', 'account/registeration/'),
        headers: {"Content-Type": "application/json"}, body: json.encode(user));
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      // await storage.write(key: 'AuthToken', value: token);
      await FlutterSession().set('token', token);
      notifyListeners();
    }
  }

  void login(String email, String password) async{
    Map data = {};
    data['username'] = email;
    data['password'] = password;

    final response = await http.post(Uri.http('192.168.43.112:8000', 'account/login/'),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    var token;
    if (response.statusCode == 200){
      token = json.decode(response.body)['token'];
      print('ok');
      print(token);
    } else{
      print('error');
    }
    // await storage.write(key: 'AuthToken', value: token);
    await FlutterSession().set('token', token);
  }
}