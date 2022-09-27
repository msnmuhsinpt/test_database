import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_database/ui/Home_screen.dart';

import '../boxes.dart';
import '../db/data_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List dName = [];
  List dId = [];
  List _user = [];

  final box = Boxes.getDataModel();

  @override
  void initState() {
    super.initState();

    readJson();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Splash Screen'),
    ));
  }

  // Fetch content from the json file
  Future readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _user = data["data"];
      for (int i = 0; i < _user.length; i++) {
        dId.add(_user[i]["id"]);
        dName.add(_user[i]["name"]);
        log("test $i");
      }

      saveData();
    });
  }

  //save to hive
  Future saveData() async {
    for (int j = 0; j < _user.length; j++) {
      DataModel addData = DataModel(
        id: dId[j].toString(),
        name: dName[j].toString(),
      );

      box.add(addData);
    }
  }

  //splash time
  Future timer() async {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }
}
