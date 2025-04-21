import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/main_app.dart';
import 'package:flutter_trainee_2025/utils/adapters/todo_type_adapter.dart';
import 'package:flutter_trainee_2025/utils/hive.dart';
import 'package:flutter_trainee_2025/utils/sqlite.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // Hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  HiveHelper();

  // Sqlite initialization
  SqliteHelper.initializeDatabase();

  runApp(const MainApp());
}