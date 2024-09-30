import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/Models/auth_user.dart';
import 'package:social_app/Widgets/post.dart';
import 'package:social_app/Widgets/text_field.dart';
import 'package:social_app/view_models/auth_view_model.dart';
import 'package:social_app/view_models/home_view_model.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import 'Profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final HomeViewModel homeController = Get.put(HomeViewModel());
  final ProfileViewModel profileController = Get.put(ProfileViewModel());
  final TextEditingController createPostText = TextEditingController();
  final AuthUser authUser = AuthUser();
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Home({super.key});

  void signOut() async {
    AuthViewModel.signOut();
  }

  void imagePicker() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        try {
          _pickedImage = pickedImage;
        } catch (e) {
          print('Error during upload: $e');
          return null;
        }
      } else {
        print('No image selected.');
        return null;
      }
    } catch (e) {
      print('Error selecting image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkGreyColor,
        title:
            const Text("Home", style: TextStyle(color: AppColors.blackColor)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
            color: AppColors.blackColor,
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const profilePage());
            },
            icon: const Icon(Icons.person),
            color: AppColors.blackColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  controller: createPostText,
                  hintText: "What's on your mind?",
                  obscureText: false,
                  isEnabled: true,
                ),
              ),
              IconButton(onPressed: imagePicker, icon: const Icon(Icons.image)),
              IconButton(
                onPressed: () {
                  homeController.createPost(
                    createPostText.text,
                    _pickedImage,
                    null,
                    authUser.email,
                    authUser.uid,
                  );
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
          Obx(() {
            if (homeController.allPosts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  itemCount: homeController.allPosts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = homeController.allPosts[index];
                    final user = profileController.firebaseUser.value;
                    return PostTile(
                      post: post,
                      user: user,
                      onFollow: () async {
                        profileController.followUser(
                            post.posterId, post.posterUid);
                      },
                      onLike: () {
                        if (post.likesList.contains(AuthUser().email)) {
                          homeController.unlikePost(post, AuthUser());
                        } else {
                          homeController.likePost(post, AuthUser());
                        }
                      },
                      onComment: () {},
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
