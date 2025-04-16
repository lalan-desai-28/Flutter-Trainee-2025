import 'package:hive/hive.dart';

import '../../models/todo.dart';

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  ToDo read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo(
      title: fields[0] ?? "",
      description: fields[1] ?? "",
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }
}
