import 'package:flutter/material.dart';
import 'package:app/pages/signup.dart';
import 'package:app/pages/login.dart';
import 'package:app/api/authentication.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/home.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isAuth = false;

  String query;

  void initState() {
    getIsAuth();
    super.initState();
  }

  getIsAuth() async{
    final token = await FlutterSession().get('token');
    setState((){
        if(token==null){
          isAuth = false;
        } else {
          isAuth = true;
        }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    List <Widget> drawerContent;
    final authP = Provider.of<AuthProvider>(context);
    
    if (!isAuth){
      drawerContent = [
        UserAccountsDrawerHeader(
          currentAccountPicture: Icon(Icons.person),
          accountName: Text('Anonymus'),
            accountEmail: Text('Login To Manage Your Todos'),
        ),
        
        ListTile(
          title: TextButton(
            child: Text('Log In'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ),
        ListTile(
          title: TextButton(
            child: Text('Sign Up'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
            },
          ),
        ),
      ];
    } 
    else {
      drawerContent = [
        UserAccountsDrawerHeader(
          currentAccountPicture: Icon(Icons.person),
          accountName: Text('Amer Sulaiman'),
            accountEmail: Text('amersulaiman10@gmail.com'),
        ),
        ListTile(
          title: TextButton(
            child: Text('Log out'),
            onPressed: (){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
              authP.logout();

              print('ok');
              var token = FlutterSession().get('token');
              print(token);
              setState(() {
                this.isAuth = false;
              });
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => Home()),
              );
              
            },
          ),
        ),
      ];
    }
    

    
    return Drawer(child: ListView( children: drawerContent));
  }
}