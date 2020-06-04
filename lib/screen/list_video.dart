import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/screen/home.dart';

class ListVideo extends StatefulWidget {
  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('List Video'),
      ),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuSignOut(),
        ],
      ),
    );
  }

  ListTile menuSignOut() => ListTile(
        onTap: () {
          Navigator.pop(context);
          signOutProcess();
        },
        leading: Icon(Icons.cached),
        title: Text('Sign Out'),
        subtitle: Text('คือการออกจาก Login'),
      );

  Future<Null> signOutProcess() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut().then((value) {
      
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Home(),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    });
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      accountName: Text('Name'),
      accountEmail: Text('Login'),
    );
  }
}
