import 'package:app/api/todoApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/Components/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        drawer: MyDrawer(),

        body: ListView.builder(
          itemCount: todoP.todos.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text(todoP.todos[index].title),
              subtitle: Text(todoP.todos[index].body),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: (){
                  todoP.deleteTask(todoP.todos[index]);
                }
              ),
            );
          },

        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed('addTodo');
          },
          
        ),

      );
  }
}