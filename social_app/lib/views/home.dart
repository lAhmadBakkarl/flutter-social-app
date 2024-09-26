import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/view_models/auth_view_model.dart';
import 'package:social_app/view_models/home_view_model.dart';

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

  @override
  void initState() {
    super.initState();
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
              Get.to(profilePage());
            },
            icon: const Icon(Icons.person),
            color: AppColors.blackColor,
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
