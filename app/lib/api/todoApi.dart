import 'package:flutter/cupertino.dart';

import 'package:app/models/todo.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class TodoProvider with ChangeNotifier{
  String base_url = '192.168.43.112:8000';

  List <Todo> _todos = [];  

  TodoProvider() {
    fetchTasks();
  }

  List<Todo> get todos{
    return [..._todos];
  }

  

  void addTask(Todo todo) async{
    final token = await FlutterSession().get('token');

    final response = http.post(Uri.http(base_url, 'todo/list/'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token $token',
    },
    body: json.encode(todo));
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

  void deleteTask(int i) async{
    
    final token = await FlutterSession().get('token');
    Todo todo = todos[i];
    print(1111);
    print(todo.id);
    print(2222);
    final response = http.delete(Uri.http(base_url, 'todo/list'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token $token',
    },
    body: json.encode({'id': todo.id}));

    _todos.removeAt(i);
    notifyListeners();
  }

  importaceChange(int i) async{
    final token = await FlutterSession().get('token');
    Todo todo = _todos[i];
    todo.important = !todo.important;

    final response = await http.put(Uri.http(base_url, 'todo/list/'), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Token $token',
    },
    body: json.encode(todo));
    _todos[i].important = !_todos[i].important;
    notifyListeners();
  }

}