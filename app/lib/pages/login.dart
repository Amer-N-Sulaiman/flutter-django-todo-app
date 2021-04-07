import 'package:flutter/material.dart';
import 'package:app/api/authentication.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    print('login');
    final authP = Provider.of<AuthProvider>(context);

    void login(){
      final email = emailController.text;
      final password = passwordController.text;

      authP.login(email, password);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In')
      ),
      body: Column(children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Text('Join Us', 
              style: TextStyle(
                letterSpacing: 5,
                color: Colors.blue[900],
                
                ),
              textAlign: TextAlign.center
            ,),
          ),
        ),
        Container(
          width: 400,
          margin: EdgeInsets.only(top: 40),
          child: Card(
            child: Container(
              margin: EdgeInsets.fromLTRB(17, 15, 17, 30),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Your Email',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Your Password',
                        ),
                      ),
                    ),
                  ),
                  
                  Center(
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        login();                        
                      },
                    
                    ),
                  )
                ],
              ),
            )
          ),
        )
        
      ])
    );
  }
}