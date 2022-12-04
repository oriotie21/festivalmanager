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
  void setStrAtPref(String key, String s) async{
    pref = await SharedPreferences.getInstance();
    pref?.setString(key, s);
  }
  Future<String?> getSession() async{
    return (await getStrFromPref("session"));
  }
  void setSession(String s) async{
    setStrAtPref("session", s);
  }
  Future<String?> getUsername() async{
    String? r = await getStrFromPref("name");
    return r;
  }
  void setUsername(String s){
    setStrAtPref("name", s);
  }

  Future<String?> getOtpKey() async{
    String? r = await getStrFromPref("otpkey");
    return r;
  }
  void setOtpKey(String s) async{
    setStrAtPref("otpkey", s);
  }

  Future<String?> getAccessToken() async{
    String? r = await getStrFromPref("access_token");
    return r;
  }
  void setAccessToken(String s) async{
    setStrAtPref("access_token", s);
  }

  Future<String?> getTokenType() async{
    String? r = await getStrFromPref("token_type");
    return r;
  }
  void setTokenType(String s) async{
    setStrAtPref("token_type", s);
  }

  Future<int?> getBoothID() async{
    pref = await SharedPreferences.getInstance();
    int? r = await pref?.getInt("booth_id");
    return r;
  }
  void setBoothID(int s) async{
    pref = await SharedPreferences.getInstance();
    pref?.setInt('booth_id', s);
  }

}