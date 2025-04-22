import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/main_app.dart';
import 'package:flutter_trainee_2025/utils/adapters/todo_type_adapter.dart';
import 'package:flutter_trainee_2025/utils/hive.dart';
import 'package:flutter_trainee_2025/utils/shared_preferences.dart';
import 'package:flutter_trainee_2025/utils/sqlite.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppSharedPreferences.preferences = await SharedPreferences.getInstance();

  // Hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  HiveHelper();

  // Sqlite initialization
  SqliteHelper.initializeDatabase();


  runApp(const MainApp());
}