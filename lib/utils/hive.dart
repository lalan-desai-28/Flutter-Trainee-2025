import 'package:hive/hive.dart';

import '../models/todo.dart';

class HiveHelper {
  static final HiveHelper _hiveHelper = HiveHelper._internal();

  late Box<ToDo> toDoBox;

  Future<void> _initializeDatabase() async {
    toDoBox = await Hive.openBox<ToDo>('hiveBox');
  }

  factory HiveHelper() {
    return _hiveHelper;
  }

  HiveHelper._internal() {
    _initializeDatabase();
  }
}
