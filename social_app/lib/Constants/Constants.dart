import 'package:get/get.dart';
import 'package:social_app/Constants/AppColors.dart';

const String SocialCollection = "Social";

void showSnackBar(String title, String message, bool success, duration) {
  Get.snackbar(title, message,
      colorText: AppColors.lightPrimary,
      backgroundColor: success ? AppColors.greenColor : AppColors.redColor,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP);
}
