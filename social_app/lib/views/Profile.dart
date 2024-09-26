import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/my_user.dart';
import 'package:social_app/Widgets/text_field.dart';
import '../Constants/AppColors.dart';

class profilePage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser!;
  profilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final emailTextFieldController = TextEditingController(text: user.email);
    final nameTextFieldController = TextEditingController();
    final bioTextFieldController = TextEditingController();
    final userNameTextFieldController = TextEditingController();
    final myUser Myuser = myUser(
      email: user.email,
      userName: userNameTextFieldController.text,
    );
    TextEditingController(text: Myuser.userName);

    void saveUser() {}

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(),
              Myuser.profilePic != null && Myuser.profilePic!.isNotEmpty
                  ? Image.network(Myuser.profilePic!, fit: BoxFit.cover)
                  : const Icon(
                      Icons.person,
                      size: 200,
                    ),
              const SizedBox(height: 20),
              MyTextField(
                  controller: emailTextFieldController,
                  hintText: "",
                  obscureText: false),
              SizedBox(height: 20),
              MyTextField(
                  controller: nameTextFieldController,
                  hintText: "Full Name",
                  obscureText: false),
              SizedBox(height: 20),
              MyTextField(
                  controller: bioTextFieldController,
                  hintText: "Bio",
                  obscureText: false),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveUser,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
