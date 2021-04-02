import 'package:flutter/material.dart';
import 'package:app/Components/drawer.dart';
import 'package:provider/provider.dart';
import 'package:app/api/todoApi.dart';
import 'package:app/models/todo.dart';

class AddTodo extends StatefulWidget {

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final todoTitle = TextEditingController();

  final todoBody = TextEditingController();

  void addTodo(){
    final title = todoTitle.text;
    final body = todoBody.text;

    final todoP = Provider.of<TodoProvider>(context, listen: false);

    Todo todo = Todo(title:title, body:body, author:1);
    todoP.addTask(todo);

  }

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo')
      ),
      drawer: MyDrawer(),
      body: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: todoTitle,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Todo Title',
                    ),
                  ),
                ),
              ),
              Center(
                child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: todoBody,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter Todo Body',
                    ),
                  ),
                ) 
              )
              ,
              Center(
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    addTodo();
                    Navigator.of(context).pop();
                  }
                ),
              )
            ],
          ),
        ),
      )
    );
    
    
  }
}