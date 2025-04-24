import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_trainee_2025/screens/dio/models/api_request_fail_model.dart';
import 'package:get/get.dart';

import '../screens/dio/utils/access_token_helper.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();

  late final Dio dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(baseUrl: "https://api-uapsnap.venko.info/api/v1/"));

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ),
    );

    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.refreshForceCache,
          maxStale: const Duration(days: 1),
        ),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Authorization"] =
              "Bearer ${AccessTokenHelper().getAccessToken()}";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.type == DioExceptionType.connectionError) {
            Get.snackbar(
              "No internet connection!",
              "No internet connection available. Please check your internet connection and try again.",
              snackPosition: SnackPosition.BOTTOM,
            );
            return handler.next(e);
          }

          final response = ApiRequestFailModel.fromJson(e.response!.data);
          Get.snackbar(
            "Error",
            response.message.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
          return handler.next(e);
        },
      ),
    );
  }
}
