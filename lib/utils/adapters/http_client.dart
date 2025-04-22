import 'package:flutter_trainee_2025/utils/http_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpClient {
  static final HttpClient _httpClient = HttpClient._internal();

  late final InterceptedHttp http;

  factory HttpClient() {
    return _httpClient;
  }

  HttpClient._internal() {
    http = InterceptedHttp.build(interceptors: [LoggerInterceptor()]);

  }
}
