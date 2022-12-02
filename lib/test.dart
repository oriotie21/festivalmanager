import 'package:festivalmanager/UserManager.dart';

class TestUnit{
  static void setAdminCredential() async{
    UserCredential credential = UserCredential();
    await credential.setToken("SIGNEDUSERNAME");
    await credential.setUsername("admin1");
  }
}