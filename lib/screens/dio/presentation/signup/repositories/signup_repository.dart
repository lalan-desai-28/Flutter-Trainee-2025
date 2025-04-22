import 'dart:convert';

import 'package:flutter_trainee_2025/screens/dio/constants/api_constants.dart';
import 'package:flutter_trainee_2025/screens/dio/models/network_facility.dart';
import 'package:flutter_trainee_2025/utils/adapters/http_client.dart';
import 'package:flutter_trainee_2025/utils/dio_client.dart';

class SignupRepository {
  Future<Object> signup(
    String fullName,
    String email,
    String password,
    String confirmPassword,
    NetworkFacility networkFacility,
  ) async {
    switch (networkFacility) {
      case NetworkFacility.dio:
        {
          return await DioClient().dio.post(
            "auth/user/signup",
            data: {
              "sFullName": fullName,
              "sEmail": email,
              "sPassword": password,
              "sConfirmPassword": confirmPassword,
            },
          );
        }
      case NetworkFacility.http:
        {
          return await HttpClient().http.post(
            Uri.parse("${ApiConstants.BASE_URL}/auth/user/signup"),
            body: jsonEncode({
              "sFullName": fullName,
              "sEmail": email,
              "sPassword": password,
              "sConfirmPassword": confirmPassword,
            }),
          );
        }
    }
  }
}
