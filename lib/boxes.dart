import 'package:hive/hive.dart';
import 'package:test_database/db/data_model.dart';

class Boxes {
  static Box<DataModel> getDataModel() => Hive.box<DataModel>('user');
}
