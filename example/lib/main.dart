import 'package:flutter/material.dart';
import 'package:flutter_app_update_dialog/flutter_app_update_dialog.dart';

class Mainapp extends StatefulWidget {
  @override
  _MainappState createState() => _MainappState();
}

class _MainappState extends State<Mainapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Showupdate(
            onTap: (){},
           // animationsec: 700,
           // contant: 'helo asif i am asif',
           // contant: '',
           // btnfontcolor: ,
           // btnfontsize: ,
           // btntext: ,
           // contantfontcolor: ,
           // contantfontsize: ,
           // curve: ,
           // heading: ,
           // headingcolor: ,
           // headingfontsize: ,
           // appBar: ,
          ),
        );
      }),
    );
  }
}
