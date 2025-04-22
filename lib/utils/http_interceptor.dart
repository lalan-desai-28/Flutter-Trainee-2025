import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

import '../screens/dio/models/api_request_fail_model.dart';
import '../screens/dio/utils/access_token_helper.dart';

class LoggerInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    request.headers[HttpHeaders.contentTypeHeader] = "application/json";
    request.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${AccessTokenHelper().getAccessToken()}";
    print('----- Request -----');
    print(request.toString());
    print(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response.statusCode != 200) {
      if (response is Response) {
        final failRep = ApiRequestFailModel.fromJson(jsonDecode(response.body));
        Get.snackbar(
          "Error",
          failRep.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    log('----- Response -----');
    log('Code: ${response.statusCode}');

    return response;
  }
}
