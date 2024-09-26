import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

const String usersCollection = "Users";
const String postsCollection = "Posts";

void showSnackBar(String title, String message, bool success, duration) {
  Get.snackbar(title, message,
      colorText: AppColors.lightPrimary,
      backgroundColor: success ? AppColors.greenColor : AppColors.redColor,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP);
}

void showLoader(message) {
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
  EasyLoading.show(status: message);
}

void hideLoader() {
  EasyLoading.dismiss();
}
