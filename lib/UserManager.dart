import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCredential{
  SharedPreferences? pref;
  static List<String> rank = ["인식 실패", "외부인", "재학생 지인", "재학생"];
  UserCredential(){
    setup();
  }
  void setup() async{
    pref = await SharedPreferences.getInstance();
  }
  Future<String?> getStrFromPref(String key) async{
    String? r;
    pref = await SharedPreferences.getInstance();
    r = await pref?.getString(key);
    return r;
  }
  Future<void> setStrAtPref(String key, String s) async{
    pref = await SharedPreferences.getInstance();
    pref?.setString(key, s);
  }
  Future<String?> getToken() async{
    Logger().v("gettoken");
    return (await getStrFromPref("token"));
  }
  Future<void> setToken(String s) async {
    Logger().v("settoken");
    await setStrAtPref("token", s);
  }
  Future<String?> getUsername() async{
    Logger().v("get");
    return ( await getStrFromPref("name"));
  }
  Future<void> setUsername(String s) async {
    Logger().v("set");
    await setStrAtPref("name", s);
  }
}