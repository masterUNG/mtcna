import 'package:flutter/material.dart';


class MyStyle {

  Color mainColor = Colors.green.shade700;
  Color darkColor = Colors.blue.shade900;


  Widget showProgress(){
    return Center(child: CircularProgressIndicator(),);
  }


  Widget mySizeBox(){
    return SizedBox(width: 5.0,height: 16.0,);
  }


  MyStyle();
  
}