import 'package:hive/hive.dart';

import '../models/todo.dart';

class HiveHelper {
  static late Box<ToDo> toDoBox;

  static Future<void> initializeDatabase() async {
    toDoBox = await Hive.openBox<ToDo>('hiveBox');
  }
}
