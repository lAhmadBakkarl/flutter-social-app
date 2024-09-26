import 'package:flutter/material.dart';

import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class LoginOrLogup extends StatefulWidget {
  const LoginOrLogup({super.key});

  @override
  State<LoginOrLogup> createState() => _LoginOrLogupState();
}

class _LoginOrLogupState extends State<LoginOrLogup> {
  bool showSignInScreen = true;

  void togglePages() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return SignInScreen(onTap: togglePages);
    } else {
      return SignUpScreen(onTap: togglePages);
    }
  }
}
