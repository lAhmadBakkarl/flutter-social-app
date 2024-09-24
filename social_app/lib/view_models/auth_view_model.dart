import 'package:get/get.dart';
import '../services/firebase_auth.dart';

class AuthViewModel extends GetxController {
  static final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  void signOut() async {
    await _firebaseAuthService.signOut();
  }

  static Future<bool> signIn(String emailAddress, String password) async {
    try {
      if (await _firebaseAuthService.signIn(emailAddress, password)) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> signUp(String emailAddress, String password) async {
    try {
      if (await _firebaseAuthService.createUser(emailAddress, password)) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
