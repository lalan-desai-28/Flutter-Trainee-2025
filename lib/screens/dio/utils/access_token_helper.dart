import 'package:flutter_trainee_2025/utils/shared_preferences.dart';

class AccessTokenHelper {
  static final AccessTokenHelper _accessTokenHelper =
      AccessTokenHelper._internal();

  factory AccessTokenHelper() {
    return _accessTokenHelper;
  }

  AccessTokenHelper._internal();

  String? getAccessToken() {
    return AppSharedPreferences.preferences.getString("token");
  }

  void setAccessToken(String token) {
    AppSharedPreferences.preferences.setString("token", token);
  }
}
