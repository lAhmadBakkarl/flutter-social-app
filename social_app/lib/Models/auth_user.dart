import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String email = FirebaseAuth.instance.currentUser?.email ?? '';
}
