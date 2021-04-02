import 'package:app/api/todoApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/Components/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  
  // AnimationController _controller;

  // Animation _colorAnimation;

  void initState() {
    super.initState();

    // _controller = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );

    // _controller.addListener(() {

    //   print(_controller.value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final todoP = Provider.of<TodoProvider>(context);

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
        duration: Duration(milliseconds: 250),
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
                    if (todoP.todos[i].important){
                      todoP.todos[i].important = !todoP.todos[i].important;
                      controllers[i].reverse();
                    }else {
                      todoP.todos[i].important = !todoP.todos[i].important;
                      controllers[i].forward();
                    }
                    
                    
                  }
                );
            }
                   
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: (){
                todoP.deleteTask(todoP.todos[i]);
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
        /*
        We could write the below code instead of the list
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
        */
          

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed('addTodo');
          },
          
        ),

      );
  }
}