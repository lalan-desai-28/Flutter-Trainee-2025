import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldsFormsTaskScreen extends StatefulWidget {
  const TextfieldsFormsTaskScreen({super.key});

  @override
  State<TextfieldsFormsTaskScreen> createState() =>
      _TextfieldsFormsTaskScreenState();
}

class _TextfieldsFormsTaskScreenState extends State<TextfieldsFormsTaskScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisibility = false;
  bool _confirmPasswordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              spacing: 10,
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter(
                      RegExp('[a-zA-Z ]'),
                      allow: true,
                    ),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !(RegExp(r"^[a-zA-Z ]+$").hasMatch(value))) {
                      return "Please enter a proper name.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                TextFormField(
                  controller: _numberController,
                  maxLength: 10,
                  maxLengthEnforcement:
                      MaxLengthEnforcement.truncateAfterCompositionEnds,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return "Please enter a proper number.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    counterText: "",
                    hintText: "Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                TextFormField(
                  controller: _emailAddressController,
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ).hasMatch(value))) {
                      return "Password should be > 8 characters and should contain at least:\n• 1 Small letter\n• 1 Capital letter\n• 1 Special character";
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Password and confirm password should match.";
                    }
                    return null;
                  },
                  obscureText: !_passwordVisibility,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed:
                          () => setState(() {
                            _passwordVisibility = !_passwordVisibility;
                          }),
                      icon:
                          _passwordVisibility
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                TextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ).hasMatch(value))) {
                      return "Password should be > 8 characters and should contain at least:\n• 1 Small letter\n• 1 Capital letter\n• 1 Special character";
                    }
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Password and confirm password should match.";
                    }
                    return null;
                  },
                  obscureText: !_confirmPasswordVisibility,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed:
                          () => setState(() {
                            _confirmPasswordVisibility =
                                !_confirmPasswordVisibility;
                          }),
                      icon:
                          _confirmPasswordVisibility
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                    ),

                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                FilledButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      _passwordVisibility = false;
                      _confirmPasswordVisibility = false;
                    });
                    if (formKey.currentState?.validate() ?? false) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Form validated successfully.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please fill the form properly.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text("Signup"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
