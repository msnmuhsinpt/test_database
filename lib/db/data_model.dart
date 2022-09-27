import 'package:hive_flutter/adapters.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  DataModel({required this.id,required this.name});

}
