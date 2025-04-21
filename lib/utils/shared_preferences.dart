import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static final AppSharedPreferences _sharedPreferences =
      AppSharedPreferences._internal();

  factory AppSharedPreferences() {
    return _sharedPreferences;
  }

  final Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  AppSharedPreferences._internal();
}
