import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/screens/dio/models/network_facility.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/signup/controllers/signup_controller.dart';
import 'package:get/get.dart';

import '../../../../../constants/image_constants.dart';
import '../../../../../widgets/custom_signup_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final SignupController _signupController = Get.put(SignupController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Widget _buildNameField() {
    return SignUpFormField(
      hintText: "Name",
      controller: _nameController,
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
        if (!GetUtils.isEmail(value!)) {
          return "Please enter a valid email address.";
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => SignUpFormField(
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
        obscureText: !_signupController.passwordVisibility.value,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              _signupController.passwordVisibility.value =
                  !_signupController.passwordVisibility.value;
            },
            icon:
                _signupController.passwordVisibility.value
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
          ),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Obx(
      () => SignUpFormField(
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
        obscureText: !_signupController.confirmPasswordVisibility.value,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              _signupController.confirmPasswordVisibility.value =
                  !_signupController.confirmPasswordVisibility.value;
            },
            icon:
                _signupController.confirmPasswordVisibility.value
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
          ),

          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildCircularHeader() {
    return Obx(
      () => CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage(ImageConstants.profileImagePlaceholder),
        child:
            _signupController.isLoading.value
                ? SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(),
                )
                : SizedBox.shrink(),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        FocusManager.instance.primaryFocus?.unfocus();
        _signupController.signup(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _confirmPasswordController.text,
        );
      },
      child: Text("Submit"),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          spacing: 10,
          children: [
            _buildCircularHeader(),
            _buildNameField(),
            _buildEmailField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),

            Obx(
              () =>
                  _signupController.isLoading.value
                      ? SizedBox.shrink()
                      : _buildSubmitButton(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("Signup Screen"),
      actions: [
        Obx(
          () => Row(
            children: [
              RadioMenuButton(
                value: NetworkFacility.dio,
                groupValue: _signupController.networkFacility.value,
                onChanged: (value) {
                  if (!_signupController.isLoading.value) {
                    _signupController.networkFacility.value =
                        NetworkFacility.dio;
                  }
                },
                child: Text("Dio"),
              ),
              RadioMenuButton(
                value: NetworkFacility.http,
                groupValue: _signupController.networkFacility.value,
                onChanged: (value) {
                  if (!_signupController.isLoading.value) {
                    _signupController.networkFacility.value =
                        NetworkFacility.http;
                  }
                },
                child: Text("Http"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), appBar: _buildAppbar());
  }
}
