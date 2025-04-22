import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../widgets/custom_signup_form_field.dart';
import '../../../models/network_facility.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCircularHeader() {
    return GestureDetector(
      onTap: () {
        _showImagePickerDialog();
      },
      child: Obx(() {
        return CircleAvatar(
          radius: 70,
          backgroundImage: _homeController.profileImageProvider.value,
          child:
              _homeController.isUpdating.value
                  ? _homeController.networkFacility.value == NetworkFacility.dio
                      ? SizedBox(
                        height: 140,
                        width: 140,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          value:
                              _homeController.uploadProgress.value != 0
                                  ? _homeController.uploadProgress.value / 100
                                  : null,
                        ),
                      )
                      : SizedBox(
                        height: 140,
                        width: 140,
                        child: CircularProgressIndicator(),
                      )
                  : SizedBox.shrink(),
        );
      }),
    );
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 120,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () {
                  // Implement camera functionality
                  _pickImage(isCamera: true).then((file) {
                    if (file != null) {
                      _homeController.setSelectedProfileImage(file);
                      Get.back();
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery"),
                onTap: () {
                  // Implement gallery functionality
                  _pickImage(isCamera: false).then((file) {
                    if (file != null) {
                      _homeController.setSelectedProfileImage(file);
                      Get.back();
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUpdateButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          FocusManager.instance.primaryFocus?.unfocus();
          _homeController.updateProfile();
        }
      },
      child: Text("Update"),
    );
  }

  Widget _buildNameField() {
    return SignUpFormField(
      hintText: "Name",
      controller: _homeController.nameController,
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
      controller: _homeController.emailController,
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

  Widget _buildNumberField() {
    return SignUpFormField(
      controller: _homeController.numberController,
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

  Future<File?> _pickImage({required bool isCamera}) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Widget _buildBody() {
    return Obx(
      () =>
          _homeController.isLoading.value
              ? Center(child: const CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 10,
                    children: [
                      Center(child: _buildCircularHeader()),
                      _buildNameField(),
                      _buildEmailField(),
                      _buildNumberField(),
                      Obx(
                        () =>
                            _homeController.isUpdating.value
                                ? SizedBox.shrink()
                                : _buildUpdateButton(),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      title: Text("Home Screen"),
      actions: [
        Obx(
          () => Row(
            children: [
              RadioMenuButton(
                value: NetworkFacility.dio,
                groupValue: _homeController.networkFacility.value,
                onChanged: (value) {
                  if (!_homeController.isUpdating.value) {
                    _homeController.networkFacility.value = NetworkFacility.dio;
                  }
                },
                child: Text("Dio"),
              ),
              RadioMenuButton(
                value: NetworkFacility.http,
                groupValue: _homeController.networkFacility.value,
                onChanged: (value) {
                  if (!_homeController.isUpdating.value) {
                    _homeController.networkFacility.value =
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

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _homeController.logout();
      },
      child: Icon(Icons.logout),
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
