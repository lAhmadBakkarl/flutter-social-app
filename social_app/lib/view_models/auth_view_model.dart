import 'package:get/get.dart';
import 'package:social_app/Models/firebase_response.dart';
import '../services/firebase_auth.dart';

class AuthViewModel extends GetxController {
  static final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  static void signOut() async {
    await _firebaseAuthService.signOut();
  }

  static Future<myFirebaseResponse> signIn(
      String emailAddress, String password) async {
    try {
      final response = await _firebaseAuthService.signIn(
        emailAddress,
        password,
      );
      return response;
    } catch (e) {
      print(e);
      return myFirebaseResponse(false, e.toString());
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
