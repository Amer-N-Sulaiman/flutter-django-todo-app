import 'package:flutter/material.dart';

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
            title: Text('Log in'),
          ),
          ListTile(
            title: Text('Sign up'),
          ),
        ]));
  }
}