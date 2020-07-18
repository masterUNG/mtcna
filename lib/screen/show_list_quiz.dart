import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/screen/exercise.dart';

import '../utility/my_style.dart';

class ShowListQuiz extends StatefulWidget {
  final String nameDocument;
  ShowListQuiz({Key key, this.nameDocument}) : super(key: key);
  @override
  _ShowListQuizState createState() => _ShowListQuizState();
}

class _ShowListQuizState extends State<ShowListQuiz> {
  String nameDocument;
  List<String> nameQuizs = List();
  List<String> nameDocInQuizs = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameDocument = widget.nameDocument;
    print('nameDocument ==>>> $nameDocument');
    readData();
  }

  Future<Null> readData() async {
    Firestore firestore = Firestore.instance;
    await firestore
        .collection('Lesson')
        .document(nameDocument)
        .collection('Quiz')
        .snapshots()
        .listen((event) {
      for (var snapshot in event.documents) {
        String string = snapshot.data['NameQuiz'];
        print('NameQuiz ==>> $string');

        String nameDoc = snapshot.documentID;
        nameDocInQuizs.add(nameDoc);

        setState(() {
          nameQuizs.add(string);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: nameQuizs.length == 0 ? MyStyle().showProgress() : buildListQuiz(),
    );
  }

  ListView buildListQuiz() {
    return ListView.builder(
      itemCount: nameQuizs.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print('You Click ==>> ${nameQuizs[index]}');
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Exercise(
              nameDocInQuiz: nameDocInQuizs[index],
              nameDocument: nameDocument,
              modeQuiz: nameQuizs[index],
            ),
          );
          Navigator.push(context, route);
        },
        child: Card(
          child: Text(
            nameQuizs[index],
          ),
        ),
      ),
    );
  }
}
