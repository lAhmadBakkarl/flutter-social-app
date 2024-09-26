import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Widgets/social_button.dart';
import 'package:social_app/Widgets/text_field.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import '../Constants/AppColors.dart';
import '../Models/auth_user.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final AuthUser authUser = AuthUser();
  final ProfileViewModel profileController =
      Get.isRegistered<ProfileViewModel>()
          ? Get.find<ProfileViewModel>()
          : Get.put(ProfileViewModel());

  bool isUploading = false;
  File? profilePic;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    profileController.fetchUserData();
  }

  void imagePicker() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          isUploading = true;
        });

        try {
          final response =
              await profileController.updateProfilePic(File(pickedImage.path));

          if (response.success) {
            print('Image uploaded successfully:');
          } else {
            print('Upload failed');
          }
        } catch (e) {
          print('Error during upload: $e');
        } finally {
          setState(() {
            isUploading = false;
          });
        }
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  void saveUser(String? name, String? bio) async {
    try {
      await profileController.updateUser(name!, bio!);
      print('Profile updated');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailTextFieldController =
        TextEditingController(text: profileController.firebaseUser?.email);
    final nameTextFieldController =
        TextEditingController(text: profileController.firebaseUser?.name);
    final bioTextFieldController =
        TextEditingController(text: profileController.firebaseUser?.bio);

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(),
                GetBuilder<ProfileViewModel>(
                    init: profileController,
                    builder: (controller) {
                      if (controller.firebaseUser == null) {
                        // showLoader('Fetching user data...');
                      }
                      return Stack(
                        children: [
                          controller.firebaseUser?.profilePic != null &&
                                  controller
                                      .firebaseUser!.profilePic!.isNotEmpty
                              ? Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: AppColors.greenColor,
                                      width: 5,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      controller.firebaseUser!.profilePic!,
                                      fit: BoxFit.cover,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: AppColors.greenColor,
                                      width: 5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: 200,
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                                color: AppColors.darkGreyColor,
                              ),
                              onPressed: imagePicker,
                            ),
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 20),
                MyTextField(
                    controller: emailTextFieldController,
                    hintText: "Email",
                    obscureText: false,
                    isEnabled: false),
                const SizedBox(height: 20),
                MyTextField(
                    controller: nameTextFieldController,
                    hintText: "Full Name",
                    obscureText: false,
                    isEnabled: true),
                const SizedBox(height: 20),
                MyTextField(
                    controller: bioTextFieldController,
                    hintText: "Bio",
                    obscureText: false,
                    isEnabled: true),
                const SizedBox(height: 20),
                myButton(
                  text: "Save",
                  color: AppColors.greenColor,
                  onPressed: () => saveUser(nameTextFieldController.text,
                      bioTextFieldController.text),
                ),
                if (isUploading)
                  Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.greenColor,
                      size: 50,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
