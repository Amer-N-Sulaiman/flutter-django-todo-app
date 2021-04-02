import 'package:flutter/cupertino.dart';

import 'package:app/models/todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class TodoProvider with ChangeNotifier{

  List <Todo> _todos = [];  

  
 

  Todo todo1 = Todo(title:'Learn to use Git', body:'you need to finish this task before the end of this month', author:1);
  Todo todo2 = Todo(title:'send requests from flutter', body:'you need to finish this task before the end of this month', author:1);
  Todo todo3 = Todo(title:'get A in University', body:'you need to focus a lot on this task', author:1);

 
  TodoProvider() {
    _todos.add(todo1);
    _todos.add(todo2);
    _todos.add(todo3);
    _todos.add(todo1);
    _todos.add(todo2);
    _todos.add(todo3);
  }

  List<Todo> get todos{
    return [..._todos];
  }

  void deleteTask(Todo todo){
    _todos.remove(todo);
    notifyListeners();
  }

  void addTask(Todo todo){
    _todos.add(todo);
    notifyListeners();
  }


  /*
  fetchTasks() async {
    
    final url = Uri.parse('http:///todo/openlist');
    final response = await http.get(Uri.http('192.168.43.112:8000', 'todo/openlist'));
    print(1);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos = data.map<Todo>((json) => Todo.fromJson(json)).toList();
      print(_todos);
      notifyListeners();
    }
  }
  */
}