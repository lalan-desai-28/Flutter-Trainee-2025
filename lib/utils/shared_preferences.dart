import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static final Future<SharedPreferences> sharedPref =
      SharedPreferences.getInstance();
}
