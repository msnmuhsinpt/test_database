import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Database'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _user.isNotEmpty
                ? Container()
                : SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      //call json
                      onPressed: () => readJson(),
                      child: const Text('Load Data'),
                    ),
                  ),
            _user.isNotEmpty
                //show data
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _user.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  _user[index]["id"],
                                ),
                                Text(
                                  _user[index]["name"],
                                ),
                              ],
                            ));
                      },
                    ),
                  )
                : const Center(
                    child: Text('No Data'),
                  )
          ],
        ));
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _user = data["data"];
    });
  }
}
