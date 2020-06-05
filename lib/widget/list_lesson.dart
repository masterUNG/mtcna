import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/screen/chapter.dart';
import 'package:mtcna/utility/my_style.dart';

class ListLesson extends StatefulWidget {
  @override
  _ListLessonState createState() => _ListLessonState();
}

class _ListLessonState extends State<ListLesson> {
  List<String> nameLessons = List();
  List<String> types = List();
  List<String> nameDocuments = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.currentUser().then((value) async {
      String uid = value.uid;

      Firestore firestore = Firestore.instance;
      await firestore
          .collection('User')
          .document(uid)
          .snapshots()
          .listen((event) {
        String status = event.data['Type'];
        readLessonData(status);
      });
    });
  }

  Future<Null> readLessonData(String status) async {
    if (nameLessons.length != 0) {
      nameLessons.clear();
      types.clear();
      nameDocuments.clear();
    }

    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Lesson');
    await collectionReference.snapshots().listen((event) {
      for (var snapshot in event.documents) {
        if (status == 'Free') {
          if (snapshot.data['Type'] == 'Free') {
            setState(() {
              nameLessons.add(snapshot.data['NameLesson']);
              types.add(snapshot.data['Type']);
              nameDocuments.add(snapshot.documentID);
            });
          }
        } else {
          setState(() {
            nameLessons.add(snapshot.data['NameLesson']);
            types.add(snapshot.data['Type']);
            nameDocuments.add(snapshot.documentID);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return nameLessons.length == 0 ? showNoData() : showListViewLesson();
  }

  ListView showListViewLesson() => ListView.builder(
        itemCount: nameLessons.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
          child: GestureDetector(
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Chapter(
                  nameChapter: nameLessons[index],
                  nameDocument: nameDocuments[index],
                ),
              );
              Navigator.push(context, route);
            },
            child: Card(
              color: Colors.lime.shade300,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(nameLessons[index]),
                    Text(
                      types[index],
                      style: TextStyle(color: MyStyle().darkColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget showNoData() => Center(child: CircularProgressIndicator());
}
