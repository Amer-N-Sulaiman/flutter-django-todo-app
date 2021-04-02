import 'package:flutter/material.dart';
import 'package:app/api/todoApi.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/addTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        routes: {
          'addTodo': (context){
            return AddTodo();
          }
        }
      ),
    );
  }
}




