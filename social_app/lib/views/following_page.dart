import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/Models/auth_user.dart';
import 'package:social_app/Widgets/post.dart';
import 'package:social_app/view_models/auth_view_model.dart';
import 'package:social_app/view_models/home_view_model.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import 'Profile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FollowingPage extends StatelessWidget {
  final HomeViewModel homeController = Get.put(HomeViewModel());
  final ProfileViewModel profileController = Get.put(ProfileViewModel());
  final TextEditingController createPostText = TextEditingController();
  final AuthUser authUser = AuthUser();

  FollowingPage({super.key});

  void signOut() async {
    AuthViewModel.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkGreyColor,
        title: const Text("Following",
            style: TextStyle(color: AppColors.blackColor)),
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
          // Wrap only the part of the UI that reacts to changes in `posts`
          Obx(() {
            if (homeController.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  itemCount: homeController.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = homeController.posts[index];
                    final user = profileController.firebaseUser.value;
                    return PostTile(
                        post: post,
                        user: user,
                        onFollow: () async {
                          profileController.followUser(
                              post.posterId, post.posterUid);
                        });
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
