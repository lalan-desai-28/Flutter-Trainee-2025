import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/todo.dart';
import 'package:flutter_trainee_2025/utils/hive.dart';
import 'package:flutter_trainee_2025/utils/sqlite.dart';

import '../../enums/storage_facility.dart';
import '../../widgets/custom_signup_form_field.dart';

class HivePlusSqliteTaskScreen extends StatefulWidget {
  const HivePlusSqliteTaskScreen({super.key});

  @override
  State<HivePlusSqliteTaskScreen> createState() =>
      _HivePlusSqliteTaskScreenState();
}

class _HivePlusSqliteTaskScreenState extends State<HivePlusSqliteTaskScreen> {
  List<ToDo> _todos = [];

  StorageFacility _selectedStorageFacility = StorageFacility.hive;

  Future<void> _getTodos() async {
    List<ToDo> temp = [];
    switch (_selectedStorageFacility) {
      case StorageFacility.hive:
        {
          temp =
              HiveHelper().toDoBox.values
                  .map((e) => ToDo(title: e.title, description: e.description))
                  .toList();
        }

      case StorageFacility.sqlite:
        {
          await SqliteHelper.database.transaction((txn) async {
            setState(() {});
            temp =
                (await txn.query("todos", columns: ["title", "description"]))
                    .map(
                      (e) => ToDo(
                        title: e["title"] as String,
                        description: e["description"] as String,
                      ),
                    )
                    .toList();
          });
        }
    }
    setState(() {
      _todos = temp;
    });
  }

  void _storeToDo() {
    switch (_selectedStorageFacility) {
      case StorageFacility.hive:
        {
          HiveHelper().toDoBox.clear().then((value) async {
            for (var element in _todos) {
              await HiveHelper().toDoBox.add(element);
            }
          });
        }

      case StorageFacility.sqlite:
        {
          SqliteHelper.database.transaction((txn) async {
            txn.delete("todos");
            for (var element in _todos) {
              txn.insert("todos", {
                "title": element.title,
                "description": element.description,
              });
            }
          });
        }
    }
  }

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  Widget _buildTodoItem(ToDo item, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        child: ListTile(
          title: Text(item.title),
          subtitle: Text(item.description),
          leading: Icon(Icons.calendar_today_outlined),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _todos.removeAt(index);
                _storeToDo();
              });
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todos[index], index);
      },
    );
  }

  SignUpFormField _buildTitleField(TextEditingController controller) {
    return SignUpFormField(hintText: "Title", controller: controller);
  }

  SignUpFormField _buildDescriptionField(TextEditingController controller) {
    return SignUpFormField(hintText: "Description", controller: controller);
  }

  Future<ToDo?> _showFormDialog() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  _buildTitleField(titleController),
                  _buildDescriptionField(descriptionController),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        ToDo newPerson = ToDo(
                          title: titleController.text,
                          description: descriptionController.text,
                        );
                        Navigator.of(context).pop(newPerson);
                      }
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      title: Text("Hive + Sqlite"),
      actions: [
        RadioMenuButton(
          value: StorageFacility.hive,
          groupValue: _selectedStorageFacility,
          onChanged: (value) {
            setState(() {
              _selectedStorageFacility = StorageFacility.hive;
              _getTodos();
            });
          },
          child: Text("Hive"),
        ),
        RadioMenuButton(
          value: StorageFacility.sqlite,
          groupValue: _selectedStorageFacility,
          onChanged: (value) {
            setState(() {
              _selectedStorageFacility = StorageFacility.sqlite;
              _getTodos();
            });
          },
          child: Text("Sqlite"),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        ToDo? toDo = await _showFormDialog();
        if (toDo != null) {
          setState(() {
            _todos.add(toDo);
          });
          _storeToDo();
        }
      },
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildHeader(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
