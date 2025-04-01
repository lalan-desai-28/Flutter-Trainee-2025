import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/widgets/custom_signup_form_field.dart';

class TextfieldsFormsTaskScreen extends StatefulWidget {
  const TextfieldsFormsTaskScreen({super.key});

  @override
  State<TextfieldsFormsTaskScreen> createState() =>
      _TextfieldsFormsTaskScreenState();
}

class _TextfieldsFormsTaskScreenState extends State<TextfieldsFormsTaskScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisibility = false;
  bool _confirmPasswordVisibility = false;

  void onSignUpClick() {
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
    }
  }

  Widget _buildSigupButton() {
    return FilledButton(
      style: ButtonStyle(),
      onPressed: () => onSignUpClick(),
      child: Text("Signup"),
    );
  }

  Widget _buildNameField() {
    return SignUpFormField(
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

  Widget _buildNumberField() {
    return SignUpFormField(
      hintText: "Number",
      maxLength: 10,
      counterText: "",
      prefixIcon: Icon(Icons.phone),
      keyboardType: TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length != 10) {
          return "Please enter a proper number.";
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buildEmailField() {
    return SignUpFormField(
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

  Widget _buildPasswordField() {
    return SignUpFormField(
      hintText: "Password",
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
        if (_passwordController.text != _confirmPasswordController.text) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return SignUpFormField(
      hintText: "Confirm Password",
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
        if (_passwordController.text != _confirmPasswordController.text) {
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
                _confirmPasswordVisibility = !_confirmPasswordVisibility;
              }),
          icon:
              _confirmPasswordVisibility
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
        ),

        hintText: "Confirm Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: formKey,
          child: Column(
            spacing: 10,
            children: [
              _buildNameField(),
              _buildNumberField(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildConfirmPasswordField(),

              _buildSigupButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("Signup Form"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildBody());
  }
}
