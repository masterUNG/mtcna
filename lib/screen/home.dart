import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtcna/screen/my_service.dart';
import 'package:mtcna/screen/register.dart';
import 'package:mtcna/utility/my_style.dart';
import 'package:mtcna/utility/normal_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool status = true;
  String email = '', password = '';

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<Null> checkStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      routeToService();
    } else {
      setState(() {
        status = false;
      });
    }
  }

  void routeToService() {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => ListVideo(),
    );
    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  Widget showLogo() {
    return Container(
      width: 180.0,
      height: 180.0,
      child: Image.asset('images/mtcna.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'MTCNA LEARNING',
      style: GoogleFonts.dancingScript(
        textStyle: TextStyle(
          fontSize: 30.0,
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.green.shade700,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => checkAuthen(),
    );
  }

  Future<Null> checkAuthen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      routeToService();
    }).catchError((value) {
      String string = value.message;
      normalDialog(context, string);
    });
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {
        print('You Click Signup');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext contex) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 10.0,
        ),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: status
            ? Center(
                child: CircularProgressIndicator(),
              )
            : showContent(),
      ),
    );
  }

  Container showContent() {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.white, Colors.green.shade700], radius: 1.0)),
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showLogo(),
            showAppName(),
            SizedBox(
              height: 8.0,
            ),
            emailForm(),
            MyStyle().mySizeBox(),
            passwordlForm(),
            showButton(),
          ],
        ),
      )),
    );
  }

  Widget emailForm() => Container(
        width: 250.0,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget passwordlForm() => Container(
        width: 250.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
      );
}
