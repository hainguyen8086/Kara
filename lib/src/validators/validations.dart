import 'package:shared_preferences/shared_preferences.dart';

class Validations {
  static bool isValidUser(String user) {
    return user != null && user.length > 6 && user.contains("@");
  }

  static bool isValidPass(String pass) {
    return pass != null && pass.length > 6;
  }

  static Future<String> prefsDat1(String key) async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    final dat1 = prefs.getString(key) ?? "null";
    return dat1;
  }
}
