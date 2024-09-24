import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/view_models/home_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
