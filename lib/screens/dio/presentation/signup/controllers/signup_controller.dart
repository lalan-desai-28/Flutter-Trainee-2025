import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_trainee_2025/screens/dio/models/network_facility.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/home/screens/home_screen.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/signup/models/signup_success_model.dart';
import 'package:flutter_trainee_2025/screens/dio/presentation/signup/repositories/signup_repository.dart';
import 'package:flutter_trainee_2025/screens/dio/utils/access_token_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SignupController extends GetxController {
  final RxBool passwordVisibility = false.obs;
  final RxBool confirmPasswordVisibility = false.obs;

  final networkFacility = Rx(NetworkFacility.dio);
  final RxBool isLoading = false.obs;
  final SignupRepository _repo = Get.put(SignupRepository());

  Future<void> signup(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) async {
    isLoading.value = true;

    try {
      final response = await _repo.signup(
        fullName,
        email,
        password,
        confirmPassword,
        networkFacility.value,
      );

      SignupSuccess signupSuccess;
      switch (networkFacility.value) {
        case NetworkFacility.dio:
          {
            response as dio.Response;
            signupSuccess = SignupSuccess.fromJson(response.data);
          }
        case NetworkFacility.http:
          {
            response as http.Response;
            signupSuccess = SignupSuccess.fromJson(jsonDecode(response.body));
          }
      }
      if (signupSuccess.data?.sToken != null) {
        AccessTokenHelper().setAccessToken(signupSuccess.data!.sToken!);
        Get.off(HomeScreen(), transition: Transition.circularReveal);
      }
    } on Exception catch (e) {
      if (e is ClientException) {
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
}
