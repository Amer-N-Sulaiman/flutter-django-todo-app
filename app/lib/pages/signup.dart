import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        controller: email,
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
                        controller: username,
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
                        controller: password,
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
                        controller: password2,
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
                      onPressed: () {},
                    
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