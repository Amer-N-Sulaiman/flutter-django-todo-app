import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/api/authentication.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final authP = Provider.of<AuthProvider>(context);
    
    void signup(){
      String email = emailController.text;
      String username = usernameController.text;
      String password = passwordController.text;
      String password2 = password2Controller.text;

      authP.signup(email, username, password, password2);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up')
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
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Your Username',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter A Password',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: password2Controller,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Confirm Your Password',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        signup();
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