import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier{
  


  void signup(String email, String username, String password, String password2) async{
    User user = User(email: email, username: username, password: password, password2: password2);
    final response = await http.post(Uri.http('192.168.43.112:8000', 'account/registeration/'),
        headers: {"Content-Type": "application/json"}, body: json.encode(user));
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      print(token);
      notifyListeners();
    }
  }
}