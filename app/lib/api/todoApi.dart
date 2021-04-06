import 'package:flutter/cupertino.dart';

import 'package:app/models/todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class TodoProvider with ChangeNotifier{

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
    
    final url = Uri.parse('http:///todo/openlist');
    final response = await http.get(Uri.http('192.168.43.112:8000', 'todo/openlist'));
    print(1);
    if (response.statusCode == 200) {
      
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