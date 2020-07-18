import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtcna/model/clipvideo_model.dart';
import 'package:mtcna/screen/playvideo.dart';

import '../utility/my_style.dart';

class ShowListVideo extends StatefulWidget {
  final String nameDocument;
  ShowListVideo({Key key, this.nameDocument}) : super(key: key);

  @override
  _ShowListVideoState createState() => _ShowListVideoState();
}

class _ShowListVideoState extends State<ShowListVideo> {
  String nameDocument;
  List<ClipVideoModel> clipVideoModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameDocument = widget.nameDocument;
    readAllVideo();
  }

  Future<Null> readAllVideo() async {
    Firestore firestore = Firestore.instance;
    await firestore
        .collection('Lesson')
        .document(nameDocument)
        .collection('ClipVideo')
        .snapshots()
        .listen((event) {
      for (var snapshot in event.documents) {
        ClipVideoModel model = ClipVideoModel.fromJson(snapshot.data);
        print('image = ${model.image}');
        setState(() {
          clipVideoModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clip Video'),
      ),
      body: clipVideoModels.length == 0
          ? MyStyle().showProgress()
          : buildListVideo(),
    );
  }

  Widget buildListVideo() => ListView.builder(
        itemCount: clipVideoModels.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => PlayVideo(clipVideoModel: clipVideoModels[index],),
            );
            Navigator.push(context, route);
          },
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Image.network(
                  clipVideoModels[index].image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          clipVideoModels[index].nameVideo,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text('เวลา ${clipVideoModels[index].time}'),
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: buildDetail(index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Text buildDetail(int index) {
    String string = clipVideoModels[index].detail;

    if (string.length > 40) {
      string = string.substring(0, 40);
      string = '$string ...';
    }

    return Text(string);
  }
}
