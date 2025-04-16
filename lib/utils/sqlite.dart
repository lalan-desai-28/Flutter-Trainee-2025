import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  static late Database database;

  static Future<void> initializeDatabase() async {
    database = await openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE todos (title TEXT, description TEXT)");
      },
    );
  }
}
