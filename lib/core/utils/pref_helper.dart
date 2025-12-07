import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper{
  static String _Tokenkey = "user_token";

  ///save token
  static Future<void> saveToken(String token) async {
   final prefs= await SharedPreferences.getInstance();
   await prefs.setString(_Tokenkey, token);
  }
  ///get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_Tokenkey);
  }
  ///clear token
  static Future<void> clearToken()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_Tokenkey);
  }

}