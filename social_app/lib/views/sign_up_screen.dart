import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/AppColors.dart';
import '../Widgets/button.dart';
import '../Widgets/text_field.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final confirmpasswordTextController = TextEditingController();
    final passwordTextController = TextEditingController();
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
                const Icon(Icons.lock_open, size: 100),
                //Create an account message
                const SizedBox(height: 30),
                const Text(
                  "Create your account",
                ),

                //email textfield
                SizedBox(height: 30),
                MyTextField(
                    controller: emailTextController,
                    hintText: "Enter your email",
                    obscureText: false),
                //password textfield
                SizedBox(height: 15),
                MyTextField(
                    controller: passwordTextController,
                    hintText: "Enter your password",
                    obscureText: true),

                SizedBox(height: 15),
                //confirm password textfield
                MyTextField(
                    controller: confirmpasswordTextController,
                    hintText: "Re-enter your password",
                    obscureText: true),

                //signup button
                SizedBox(height: 15),
                Button(
                    text: "Sign Up",
                    color: AppColors.blueColor,
                    onPressed: () {}),
                //not a member? register now
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignInScreen());
                      },
                      child: const Text(
                        "Login now",
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
