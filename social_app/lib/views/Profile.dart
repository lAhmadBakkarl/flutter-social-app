import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Constants/Constants.dart';
import 'package:social_app/Widgets/social_button.dart';
import 'package:social_app/Widgets/text_field.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import '../Constants/AppColors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final ProfileViewModel profileController =
      Get.isRegistered<ProfileViewModel>()
          ? Get.find<ProfileViewModel>()
          : Get.put(ProfileViewModel());

  var isUploading = false.obs;
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
        isUploading.value = true;

        try {
          final response =
              await profileController.updateProfilePic(File(pickedImage.path));
          if (response.success) {
            print('Image uploaded successfully');
          } else {
            print('Upload failed');
          }
        } catch (e) {
          print('Error during upload: $e');
        } finally {
          isUploading.value = false;
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
      showSnackBar("success", "updated", true, 2);
      print('Profile updated');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Obx(() {
              final user = profileController.firebaseUser.value;

              // ignore: unnecessary_null_comparison
              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final emailTextFieldController =
                  TextEditingController(text: user.email);
              final nameTextFieldController =
                  TextEditingController(text: user.name);
              final bioTextFieldController =
                  TextEditingController(text: user.bio);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Stack(
                    children: [
                      user.profilePic != null && user.profilePic!.isNotEmpty
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
                                  user.profilePic!,
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
                  ),
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
                  Obx(() {
                    return isUploading.value
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.greenColor,
                              size: 50,
                            ),
                          )
                        : Container();
                  }),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
