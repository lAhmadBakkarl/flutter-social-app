import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/Widgets/button.dart';
import 'package:social_app/Widgets/text_field.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
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
                    obscureText: false),
                //password textfield
                SizedBox(height: 15),
                MyTextField(
                    controller: passwordTextController,
                    hintText: "Enter your password",
                    obscureText: true),

                //login button
                SizedBox(height: 15),
                Button(
                    text: "Sign In",
                    color: AppColors.blueColor,
                    onPressed: () {}),
                //not a member? register now
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SignUpScreen());
                      },
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
