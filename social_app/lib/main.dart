import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/view_models/home_view_model.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import 'package:social_app/views/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseConfig,
  );
  Get.put(ProfileViewModel());
  Get.put(HomeViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Auth(),
      builder: EasyLoading.init(),
    );
  }
}
