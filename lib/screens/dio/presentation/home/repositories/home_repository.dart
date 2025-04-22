import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_trainee_2025/screens/dio/models/network_facility.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

import '../../../../../utils/dio_client.dart';
import '../../../constants/api_constants.dart';
import '../../../utils/access_token_helper.dart';

class HomeRepository {
  Future<Response> profileDetails() async {
    return await DioClient().dio.get("user/view/profile/details");
  }

  Future<Object?> updateProfile(
    File? uploadFile,
    String fullName,
    String email,
    String phoneNumber,
    NetworkFacility networkFacility, {
    Function(int count, int total)? onSendProgress,
  }) async {
    switch (networkFacility) {
      case NetworkFacility.dio:
        {
          FormData data = FormData.fromMap({
            "sUserName": fullName,
            "sEmail": email,
            "nPhoneNumber": phoneNumber,

            if (uploadFile != null)
              'uploadfile': await MultipartFile.fromFile(
                uploadFile.path,
                filename: uploadFile.path.split('/').last,
                contentType: DioMediaType("image", "jpeg"),
              ),
          });

          return await DioClient().dio.patch(
            "user/profile/update",
            options: Options(headers: {"Content-Type": "multipart/form-data"}),
            data: data,
            onSendProgress: onSendProgress,
          );
        }
      case NetworkFacility.http:
        {
          
          try {
            final req = http.MultipartRequest(
              "PATCH",
              Uri.parse("${ApiConstants.BASE_URL}/user/profile/update"),
            );
            req.headers['Content-Type'] = "multipart/form-data";
            req.fields["sUserName"] = fullName;
            req.fields["sEmail"] = email;
            req.fields["nPhoneNumber"] = phoneNumber;
            req.headers['Authorization'] =
                "Bearer ${AccessTokenHelper().getAccessToken()}";
            
            if (uploadFile != null) {
              req.files.add(
                await http.MultipartFile.fromPath(
                  'uploadfile',
                  uploadFile.path,
                  contentType: http_parser.MediaType("image", "jpeg"),
                ),
              );
            }
            return await req.send();

          } on Exception catch (e) {
            if (e is http.ClientException) {
              Get.snackbar(
                "No internet connection!",
                "No internet connection available. Please check your internet connection and try again.",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }


        }
    }
    return null;
  }
}
