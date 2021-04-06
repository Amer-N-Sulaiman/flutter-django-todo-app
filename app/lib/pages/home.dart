import 'package:app/api/todoApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/Components/drawer.dart';
import 'package:app/pages/addTodo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  


  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);
    
    
    todoP.fetchTasks();
    List<Widget> homeWidgets = [];

    homeWidgets.add(
      TweenAnimationBuilder(
        duration: Duration(milliseconds: 1400),
        tween: Tween<double>(begin:0, end:1),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Text('Welcome To You Todos', style: TextStyle(
            fontSize: 30,
            letterSpacing: 2,
          ), textAlign: TextAlign.center,),
        ),
        builder: (BuildContext context, double _val, Widget child){
          return Opacity(
            opacity: _val,
            child: child,
          );
        }
      )
    );

    List <AnimationController> controllers= [];

    List <Animation> colorAnimations = [];

    for (var i=0; i<todoP.todos.length; i++){
      AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      );


      controllers.add(controller);
      controllers[i].addListener(() {
        print(controllers[i].value);
      });
      Animation _colorAnimation;

      if (!todoP.todos[i].important){
        _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
          .animate(controllers[i]);
        
      } else {
        _colorAnimation = ColorTween(begin: Colors.red, end: Colors.grey[400])
          .animate(controllers[i]);
      }
      


      colorAnimations.add(_colorAnimation);

      homeWidgets.add(ListTile(
        title: Text(todoP.todos[i].title),
        subtitle: Text(todoP.todos[i].body),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedBuilder(
              animation: controllers[i],
              builder: (BuildContext context, _){
                return IconButton(
                  icon: Icon(Icons.notification_important, color: colorAnimations[i].value),
                  onPressed: (){
                    // todoP.todos[i].important = !todoP.todos[i].important;
                    if (todoP.todos[i].animationStatus){
                      todoP.todos[i].animationStatus = !todoP.todos[i].animationStatus;
                      controllers[i].reverse();
                      todoP.todos[i].important = !todoP.todos[i].important;
                    }else {
                      
                      
                      controllers[i].forward();
                      todoP.todos[i].animationStatus = !todoP.todos[i].animationStatus;
                      todoP.todos[i].important = !todoP.todos[i].important;
                    }
                    
                    
                  }
                );
            }
                   
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: (){
                todoP.deleteTask(i);
                controllers.removeAt(i);
                colorAnimations.removeAt(i);
              }
            )
          ],
        )
      ));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        drawer: MyDrawer(),

        body: TweenAnimationBuilder(
          duration: Duration(milliseconds: 1500),
          tween: Tween<double>(begin: 1, end: 0),
          child: ListView(children: homeWidgets,),
          builder: (BuildContext context, double _val, Widget child){
            return Padding(
              child: child,
              padding: EdgeInsets.only(bottom: _val*1000),
            );
          }
        ),
          

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  color: Colors.white10,
                  child: Center(
                    child: AddTodo(),
                  ),
                );
              },
            );
          },
          
        ),

      );
  }
}