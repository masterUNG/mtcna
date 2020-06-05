import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/utility/my_style.dart';

class Chapter extends StatefulWidget {
  final String nameChapter;
  final String nameDocument;
  Chapter({Key key, this.nameChapter, this.nameDocument}) : super(key: key);
  @override
  _ChapterState createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  String nameLesson, nameDocument;
  bool status = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameLesson = widget.nameChapter;
    nameDocument = widget.nameDocument;
    readData();
  }

  Future<Null> readData() async {
    Firestore firestore = Firestore.instance;
    await firestore
        .collection('Lesson')
        .document(nameDocument)
        .collection('ClipVideo')
        .snapshots()
        .listen((event) {
      print('length event ==>> ${event.documents.length}');
      if (event.documents.length != 0) {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status
          ? Center(
              child: Text('ยังไม่มี บทเรียนคะ'),
            )
          : showContent(),
      appBar: AppBar(
        title: Text(nameLesson),
      ),
    );
  }

  Widget showContent() => Column(
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(child: videoCard()),
              Expanded(child: quizCard()),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(child: flashCard()),
              Expanded(child: MyStyle().mySizeBox()),
            ],
          )
        ],
      );

  GestureDetector videoCard() {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Image.asset('images/video.png'),
              ),
              Text('Clip Video')
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector quizCard() {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Image.asset('images/video.png'),
              ),
              Text('Quiz')
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector flashCard() {
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Image.asset('images/video.png'),
              ),
              Text('Flash Card')
            ],
          ),
        ),
      ),
    );
  }
}
