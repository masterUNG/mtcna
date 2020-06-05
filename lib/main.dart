import 'package:flutter/material.dart';
import 'package:mtcna/screen/home.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'MTCNA',
      home: Home(),
    );
  }
}
