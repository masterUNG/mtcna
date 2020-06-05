import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatefulWidget {
  @override
  _ListLessonState createState() => _ListLessonState();
}

class _ListLessonState extends State<ListLesson> {
  List<String> nameLessons = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLessonData();
  }

  Future<Null> readLessonData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Lesson');
    await collectionReference.snapshots().listen((event) {
      for (var snapshot in event.documents) {
        print('NameLesson = ${snapshot.data['NameLesson']}');
        setState(() {
          nameLessons.add(snapshot.data['NameLesson']);
        });
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
          child: Card(
            child: Container(padding: EdgeInsets.all(8.0),
              child: Text(nameLessons[index]),
            ),
          ),
        ),
      );

  Widget showNoData() => Center(child: CircularProgressIndicator());
}
