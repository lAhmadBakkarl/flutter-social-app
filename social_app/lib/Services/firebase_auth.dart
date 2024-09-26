import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/Models/firebase_response.dart';
import 'package:social_app/Services/firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to create a user with email and password
  Future<bool> createUser(String emailAddress, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print('User successfully created!');

      return FirestoreService.createUser(
          _firebaseAuth.currentUser!.uid, emailAddress);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Method to sign in a user with email and password
  Future<myFirebaseResponse> signIn(
      String emailAddress, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print('User signed in successfully!');
      return myFirebaseResponse(true, "User signed in successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        print('invalid-credential');
      }
      return myFirebaseResponse(false, e.message.toString());
    } catch (e) {
      print(e);
      return myFirebaseResponse(false, e.toString());
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('User signed out successfully!');
    } catch (e) {
      print('Sign out failed: $e');
    }
  }
}
