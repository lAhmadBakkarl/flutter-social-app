import 'package:flutter/material.dart';
import 'package:social_app/Constants/Constants.dart';
import '../Constants/AppColors.dart';
import '../Widgets/social_button.dart';
import '../Widgets/text_field.dart';
import '../view_models/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onTap;
  const SignUpScreen({super.key, required this.onTap});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool fieldsValidation() {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        confirmpasswordTextController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (fieldsValidation()) {
      if (confirmpasswordTextController.text == passwordTextController.text) {
        if (await AuthViewModel.signUp(
            emailTextController.text, passwordTextController.text)) {
          showSnackBar("Success", "Account created", true, 1);
        } else {
          if (context.mounted) {
            Navigator.pop(context);
          }
          showSnackBar("Error", "Something went wrong", false, 2);
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
        }
        showSnackBar("Error", "Passwords don't match", false, 2);
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
      showSnackBar("Error", "Please fill all the fields", false, 2);
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
                const Icon(Icons.lock_open, size: 100),
                //Create an account message
                const SizedBox(height: 30),
                const Text(
                  "Create your account",
                ),

                //email textfield
                const SizedBox(height: 30),
                MyTextField(
                    controller: emailTextController,
                    hintText: "Enter your email",
                    obscureText: false),
                //password textfield
                const SizedBox(height: 15),
                MyTextField(
                    controller: passwordTextController,
                    hintText: "Enter your password",
                    obscureText: true),

                const SizedBox(height: 15),
                //confirm password textfield
                MyTextField(
                    controller: confirmpasswordTextController,
                    hintText: "Re-enter your password",
                    obscureText: true),

                //signup button
                const SizedBox(height: 15),
                Button(
                    text: "Sign Up",
                    color: AppColors.blueColor,
                    onPressed: signUp),
                //not a member? register now
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member? "),
                    GestureDetector(
                      onTap: widget.onTap,
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
