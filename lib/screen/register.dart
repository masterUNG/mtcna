import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/screen/list_video.dart';
import 'package:mtcna/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formkey = GlobalKey<FormState>();
  String nameString, emailString, passwordString, validateString;

  //method
  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.save_alt),
      onPressed: () {
        print('You clik Upload');
        if (formkey.currentState.validate()) {
          formkey.currentState.save();
          print(
              'name = $nameString, email = $emailString, password = $passwordString validate = $validateString');

          if (passwordString == validateString) {
            registerThread();
          } else {
            normalDialog(context, 'Password ไม่เหมือกัน กรุณาพิมพ์ ใหม่ คะ');
          }
        }
      },
    );
  }

  Future<Null> registerThread() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((value) {
          FirebaseUser firebaseUser = value.user;
          UserUpdateInfo info = UserUpdateInfo();
          info.displayName = nameString;
          firebaseUser.updateProfile(info);

          MaterialPageRoute route = MaterialPageRoute(builder: (context) => ListVideo(),);
          Navigator.pushAndRemoveUntil(context, route, (route) => false);

        })
        .catchError((value) {
          String string = value.message;
          normalDialog(context, string);
        });
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.account_box,
            color: Colors.green.shade700,
            size: 50.0,
          ),
          labelText: 'Display Name :',
          helperText: 'Please type your name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please fill your name';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.green.shade700,
            size: 50.0,
          ),
          labelText: 'Email :',
          helperText: 'Please type your Email'),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Your Email again';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.green.shade700,
              size: 50.0,
            ),
            labelText: 'Password :',
            helperText: 'Please type your password'),
        validator: (String value) {
          if (value.length < 6) {
            return 'Please set passwore at least 6 Charactors';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          passwordString = value.trim();
        });
  }

  Widget confirmText() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.green.shade700,
              size: 50.0,
            ),
            labelText: 'Verify your password :  :',
            helperText: 'Please type your password again'),
        validator: (String value) {
          if (value.length < 6) {
            return 'Please set passwore at least 6 Charactors';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          validateString = value.trim();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
            confirmText(),
          ],
        ),
      ),
    );
  }
}
