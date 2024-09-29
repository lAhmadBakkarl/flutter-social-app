import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/views/bottom_bar_page.dart';
import 'login_or_logup.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return const Home();
              return BottomBarPage(0);
            } else {
              return const LoginOrLogup();
            }
          }),
    );
  }
}
