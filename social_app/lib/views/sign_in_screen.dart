import 'package:flutter/material.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/Constants/Constants.dart';
import 'package:social_app/Widgets/social_button.dart';
import 'package:social_app/Widgets/text_field.dart';

import '../view_models/auth_view_model.dart';

class SignInScreen extends StatefulWidget {
  final Function() onTap;
  const SignInScreen({super.key, required this.onTap});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      final response = await AuthViewModel.signIn(
          emailTextController.text, passwordTextController.text);
      if (response.success) {
        showSnackBar('Success', 'You are logged in successfully', true, 3);
      } else {
        showSnackBar('Error', response.message, false, 4);
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
      showSnackBar('Error', 'Please fill all the fields', false, 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Icon(Icons.lock, size: 100),
                //wlecome back message
                const SizedBox(height: 30),
                const Text(
                  "Welcome back, you've been missed!",
                ),

                //email textfield
                SizedBox(height: 30),
                MyTextField(
                  controller: emailTextController,
                  hintText: "Enter your email",
                  obscureText: false,
                  isEnabled: true,
                ),
                //password textfield
                SizedBox(height: 15),
                MyTextField(
                  controller: passwordTextController,
                  hintText: "Enter your password",
                  obscureText: true,
                  isEnabled: true,
                ),

                //login button
                SizedBox(height: 15),
                myButton(
                    text: "Sign In",
                    color: AppColors.blueColor,
                    onPressed: signIn),
                //not a member? register now
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
