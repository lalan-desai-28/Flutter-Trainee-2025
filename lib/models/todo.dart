import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  ToDo({required this.title, required this.description});

  @override
  String toString() {
    return "Title: $title Description $description";
  }
}
