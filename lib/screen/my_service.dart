import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/screen/home.dart';
import 'package:mtcna/utility/my_style.dart';
import 'package:mtcna/widget/information.dart';
import 'package:mtcna/widget/list_lesson.dart';

class ListVideo extends StatefulWidget {
  @override
  _ListVideoState createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  String nameLogin, nameAppBar = 'บทเรียน';
  Widget currentWidget = ListLesson();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: currentWidget,
      drawer: showDrawer(),
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text(nameAppBar),
      ),
    );
  }

  Drawer showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuListLesson(),
          menuInformation(),
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

  ListTile menuListLesson() => ListTile(
        onTap: () {
          setState(() {
            nameAppBar = 'บทเรียน';
            currentWidget = ListLesson();
          });
          Navigator.pop(context);
        },
        leading: Icon(Icons.list),
        title: Text('List Lesson'),
        subtitle: Text('Display All Lesson'),
      );

  ListTile menuInformation() => ListTile(
        onTap: () {
          setState(() {
            nameAppBar = 'รายละเอียดของเรา';
            currentWidget = Informaion();
          });
          Navigator.pop(context);
        },
        leading: Icon(Icons.info),
        title: Text('Information'),
        subtitle: Text('Display About Me and Information'),
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
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text(
        nameLogin == null ? '' : nameLogin,
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().darkColor),
      ),
    );
  }
}
