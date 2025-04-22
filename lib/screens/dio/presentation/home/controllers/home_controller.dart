import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_trainee_2025/constants/image_constants.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/home/models/profile_success_model.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/home/repositories/home_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../models/network_facility.dart';
import '../../../utils/access_token_helper.dart';
import '../models/profile_update_success_model.dart';

class HomeController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isUpdating = false.obs;
  final Rx<ImageProvider> profileImageProvider = Rx<ImageProvider>(
    AssetImage(ImageConstants.profileImagePlaceholder),
  );

  final Rx<File?> profileImageFile = Rx<File?>(null);

  final Rx<String?> accessToken = Rx<String?>(null);
  final Rx<double> uploadProgress = Rx<double>(0);
  final networkFacility = Rx(NetworkFacility.dio);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final HomeRepository _homeRepository = Get.put(HomeRepository());

  @override
  void onInit() {
    super.onInit();
    getInitialData();
  }

  void setSelectedProfileImage(File file) {
    profileImageFile.value = file;
    profileImageProvider.value = FileImage(file);
  }

  void logout() {
    AccessTokenHelper().setAccessToken("");
    Get.delete<HomeController>();
    Get.offNamed("/signup_screen");
    dispose();
  }

  Future<void> getInitialData() async {
    try {
      final response = await _homeRepository.profileDetails();
      ProfileSuccess data = ProfileSuccess.fromJson(response.data);

      nameController.text = data.data!.sFullName.toString();
      emailController.text = data.data!.sEmail.toString();
      if (data.data?.nPhoneNumber != null) {
        numberController.text = (data.data?.nPhoneNumber).toString();
      }

      if (data.data?.sProfileImage != null) {
        profileImageFile.value = null;

        profileImageProvider.value = NetworkImage(data.data!.sProfileImage!);
      }
    } on Exception catch (e) {
      if (e is http.ClientException) {
        Get.snackbar(
          "No internet connection!",
          "No internet connection available. Please check your internet connection and try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    try {
      isUpdating.value = true;
      final response = await _homeRepository.updateProfile(
        profileImageFile.value,
        nameController.text,
        emailController.text,
        numberController.text,
        networkFacility.value,
        onSendProgress: (count, total) {
          final percentage = (count / total * 100);
          print(percentage);
          uploadProgress.value = percentage == 100.0 ? 0 : percentage;
        },
      );
      ProfileUpdateSuccess profileUpdateSuccess;
      switch (networkFacility.value) {
        case NetworkFacility.dio:
          {
            response as dio.Response;
            profileUpdateSuccess = ProfileUpdateSuccess.fromJson(response.data);
          }
        case NetworkFacility.http:
          response as http.StreamedResponse;
          final res = await http.Response.fromStream(response);
          profileUpdateSuccess = ProfileUpdateSuccess.fromJson(
            jsonDecode(res.body),
          );
      }

      nameController.text = profileUpdateSuccess.data!.sFullName.toString();
      emailController.text = profileUpdateSuccess.data!.sEmail.toString();
      if (profileUpdateSuccess.data?.nPhoneNumber != null) {
        numberController.text =
            (profileUpdateSuccess.data?.nPhoneNumber).toString();
      }

      Get.snackbar(
        "Updated!",
        "Your profile has been updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
      uploadProgress.value = 0;
    }
  }
}
