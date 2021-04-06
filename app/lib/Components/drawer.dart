import 'package:flutter/material.dart';
import 'package:app/pages/signup.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView( children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(Icons.person),
            accountName: Text('Amer Sulaiman'),
             accountEmail: Text('amersulaiman10@gmail.com'),
          ),
          ListTile(
            title: TextButton(
              child: Text('Log In'),
              onPressed: () {},
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
        ]));
  }
}