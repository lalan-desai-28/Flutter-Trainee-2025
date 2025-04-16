import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/models/person.dart';
import 'package:flutter_trainee_2025/widgets/custom_signup_form_field.dart';
import 'package:get/get.dart';

class PersonAddUpdateScreen extends StatefulWidget {
  final Function(Person person)? onPersonAdd;

  const PersonAddUpdateScreen({super.key, this.onPersonAdd});

  @override
  State<PersonAddUpdateScreen> createState() => _PersonAddUpdateScreenState();
}

class _PersonAddUpdateScreenState extends State<PersonAddUpdateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isFemale = false;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      _isUpdating = Get.arguments['isUpdating'];
      _nameController.text = (Get.arguments['oldPerson'] as Person).name;
      _emailController.text =
          (Get.arguments['oldPerson'] as Person).emailAddress;
      _isFemale = (Get.arguments['oldPerson'] as Person).isFemale ?? false;
    }
  }

  Widget _buildNameField() {
    return SignUpFormField(
      controller: _nameController,
      hintText: "Name",
      prefixIcon: Icon(Icons.person),

      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !(RegExp(r"^[a-zA-Z ]+$").hasMatch(value))) {
          return "Please enter a proper name.";
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter(RegExp('[a-zA-Z ]'), allow: true),
      ],
    );
  }

  Widget _buildEmailField() {
    return SignUpFormField(
      controller: _emailController,
      hintText: "Email",
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
          return "Please enter a proper email address.";
        }
        return null;
      },
    );
  }

  void _insertStudent() {
    if (_formKey.currentState!.validate()) {
      Get.back(
        result: Person(
          _nameController.text,
          _emailController.text,
          isFemale: _isFemale,
        ),
      );
    }
  }

  Widget _buildGenderButtons() {
    return Row(
      children: [
        RadioMenuButton(
          value: false,
          groupValue: _isFemale,
          onChanged: (value) {
            setState(() {
              _isFemale = false;
            });
          },
          child: Text("Male"),
        ),
        RadioMenuButton(
          value: true,
          groupValue: _isFemale,
          onChanged: (value) {
            setState(() {
              _isFemale = true;
            });
          },
          child: Text("Female"),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              CircleAvatar(
                minRadius: 70,
                child: Icon(_isFemale ? Icons.girl : Icons.boy, size: 120),
              ),
              _buildNameField(),
              _buildEmailField(),
              _buildGenderButtons(),
              ElevatedButton(
                onPressed: () {
                  _insertStudent();
                },
                child: Text(_isUpdating ? "Update" : "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
