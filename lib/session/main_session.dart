//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Session {
//   static late SharedPreferences prefs;
//
//   static init() async {
//     prefs = await SharedPreferences.getInstance();
//   }
//
//
//   static void save(String key, String value) {
//     prefs.setString(key, value);
//   }
//
//   static void saveInt(String key, int value) {
//     prefs.setInt(key, value);
//   }
//
//   static String get(String key, String def) {
//     return prefs.getString(key) ?? def;
//   }
//
//   static remove(String key) {
//     prefs.remove(key);
//   }
// }
