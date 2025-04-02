import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/models/person.dart';
import 'package:flutter_trainee_2025/widgets/custom_signup_form_field.dart';

class StreamsTaskScreen extends StatefulWidget {
  const StreamsTaskScreen({super.key});

  @override
  State<StreamsTaskScreen> createState() => _StreamsTaskScreenState();
}

class _StreamsTaskScreenState extends State<StreamsTaskScreen> {
  final StreamController<List<Person>> _peopleStreamController =
      StreamController<List<Person>>();
  late final Stream<List<Person>> _peopleStream =
      _peopleStreamController.stream;
  final List<Person> _peopleList = [];

  void _streamNewPerson(Person person) {
    _peopleList.add(person);
    _peopleStreamController.add(_peopleList);
  }

  void _streamDeletePerson(int personAtIndex) {
    _peopleList.removeAt(personAtIndex);
    _peopleStreamController.add(_peopleList);
  }

  void _streamUpdatePerson(Person person, int personAtIndex) {
    _peopleList[personAtIndex] = person;
    _peopleStreamController.add(_peopleList);
  }

  Future<void> _showInsertForm() async {
    Person? newPerson = await _showFormDialog();
    if (newPerson != null) _streamNewPerson(newPerson);
  }

  Future<void> _showUpdateForm(int personUpdateIndex, Person oldPerson) async {
    Person? updatedPerson = await _showFormDialog(
      isUpdate: true,
      oldPerson: oldPerson,
    );
    if (updatedPerson != null) {
      _streamUpdatePerson(updatedPerson, personUpdateIndex);
    }
  }

  SignUpFormField _buildNameField(TextEditingController controller) {
    return SignUpFormField(
      hintText: "Name",
      controller: controller,
      prefixIcon: Icon(Icons.person),

      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !(RegExp(r"^[a-zA-Z ]+$").hasMatch(value))) {
          return "Please enter a valid name.";
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter(RegExp('[a-zA-Z ]'), allow: true),
      ],
    );
  }

  SignUpFormField _buildEmailField(TextEditingController controller) {
    return SignUpFormField(
      hintText: "Email",
      controller: controller,
      prefixIcon: Icon(Icons.email),
      inputFormatters: [
        FilteringTextInputFormatter(
          RegExp("[a-z0-9.@]"),
          allow: true,
          replacementString: '',
        ),
      ],
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))) {
          return "Please enter a valid email address.";
        }
        return null;
      },
    );
  }

  Future<Person?> _showFormDialog({
    bool isUpdate = false,
    Person? oldPerson,
  }) async {
    if (isUpdate && oldPerson == null) throw "oldPerson can not be null.";

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    if (oldPerson != null) {
      nameController.text = oldPerson.name;
      emailController.text = oldPerson.emailAddress;
    }

    final formKey = GlobalKey<FormState>();
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  _buildNameField(nameController),
                  _buildEmailField(emailController),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState?.validate() ?? false) {
                        Person newPerson = Person(
                          nameController.text,
                          emailController.text,
                        );
                        Navigator.of(context).pop(newPerson);
                      }
                    },
                    child: Text(isUpdate ? "Update" : "Save"),
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
    return AppBar(title: Text("Streams"));
  }

  Widget _buildBody() {
    return SafeArea(
      child: StreamBuilder(
        stream: _peopleStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    _showUpdateForm(index, snapshot.data![index]);
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].emailAddress),
                      trailing: IconButton(
                        onPressed: () {
                          _streamDeletePerson(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("List is empty!"));
          }
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _showInsertForm(),
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
