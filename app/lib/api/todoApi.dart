import 'package:flutter/cupertino.dart';

import 'package:app/models/todo.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class TodoProvider with ChangeNotifier{
  String base_url = '192.168.1.4:8000';

  List <Todo> _todos = [];  

  TodoProvider() {
    fetchTasks();
  }

  List<Todo> get todos{
    return [..._todos];
  }

  void deleteTask(int i){
    _todos.removeAt(i);
    notifyListeners();
  }

  void addTask(Todo todo){
    _todos.add(todo);
    notifyListeners();
  }


  
  fetchTasks() async {
    
    final url = Uri.parse('http:/todo/openlist');
    final token = await FlutterSession().get('token');


    final response = await http.get(Uri.http(base_url, 'todo/list/'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token $token',
    });
    print(1);
    if (response.statusCode == 200) {
      print('o');
      var data = json.decode(response.body) as List;
      print(2);
      _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
      print(_todos);
      notifyListeners();
    } else{
      print('error');
    }
  }

}