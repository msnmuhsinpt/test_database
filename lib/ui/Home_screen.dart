import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../db/data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel> listUser = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listUser.length,
              itemBuilder: (context, position) {
                DataModel getUser = listUser[position];
                var id = getUser.id;
                var name = getUser.name;
                return Align(
                  alignment: Alignment.center,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Id:  $id',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          'Name :$name',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  void getUser() async {
    final box = await Hive.openBox<DataModel>('user');
    setState(() {
      listUser = box.values.toList();
    });
  }
}
