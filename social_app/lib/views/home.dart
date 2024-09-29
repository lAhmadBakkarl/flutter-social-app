import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/Models/auth_user.dart';
import 'package:social_app/Models/my_user.dart';
import 'package:social_app/Widgets/post.dart';
import 'package:social_app/Widgets/text_field.dart';
import 'package:social_app/view_models/auth_view_model.dart';
import 'package:social_app/view_models/home_view_model.dart';
import 'package:social_app/view_models/profile_view_model.dart';

import 'Profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeViewModel homeController = Get.isRegistered<HomeViewModel>()
      ? Get.find<HomeViewModel>()
      : Get.put(HomeViewModel());

  final TextEditingController createPostText = TextEditingController();
  AuthUser authUser = AuthUser();

  final ProfileViewModel profileController =
      Get.isRegistered<ProfileViewModel>()
          ? Get.find<ProfileViewModel>()
          : Get.put(ProfileViewModel());

  myUser? user;

  void fetchUserData() async {
    final fetchedUser = await profileController.fetchUserData();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void signOut() async {
    AuthViewModel.signOut();
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
              Get.to(const profilePage());
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
              )),
              IconButton(
                  onPressed: () {
                    homeController.createPost(
                        createPostText.text, null, null, authUser.email);
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
          GetBuilder<HomeViewModel>(
              init: homeController,
              builder: (controller) {
                if (controller.posts.isEmpty) {
                  return CircularProgressIndicator();
                }
                return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: controller.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PostTile(
                              post: controller.posts[index],
                              user: user,
                            );
                          },
                        )));
              })
        ],
      ),
    );
  }
}
