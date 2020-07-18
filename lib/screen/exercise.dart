import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/model/exercise_model.dart';

class Exercise extends StatefulWidget {
  final String modeQuiz;
  final String nameDocument;
  final String nameDocInQuiz;
  Exercise({Key key, this.modeQuiz, this.nameDocument, this.nameDocInQuiz})
      : super(key: key);
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  String modeQuiz;
  String nameDocument;
  String nameDocInQuiz;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modeQuiz = widget.modeQuiz;
    nameDocument = widget.nameDocument;
    nameDocInQuiz = widget.nameDocInQuiz;
    print('modeQuiz = $modeQuiz');
    print('nameDocument = $nameDocument');
    print('nameDocInQuiz = $nameDocInQuiz');
    readData();
  }

  Future<Null> readData() async {
    Firestore firestore = Firestore.instance;
    await firestore
        .collection('Lesson')
        .document(nameDocument)
        .collection('Quiz')
        .document(nameDocInQuiz)
        .collection(modeQuiz)
        .snapshots()
        .listen((event) {
      print('snapshots ==>> ${event.documents}');
      for (var snapshot in event.documents) {
        ExerciseModel model = ExerciseModel.fromJson(snapshot.data);
        String question = model.question;
        print('Question = $question');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modeQuiz),
      ),
    );
  }
}
