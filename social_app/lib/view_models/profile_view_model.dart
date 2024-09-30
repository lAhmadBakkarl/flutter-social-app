import 'dart:io';
import 'package:get/get.dart';
import 'package:social_app/Models/my_user.dart';
import 'package:social_app/Models/upload_response.dart';
import '../Models/auth_user.dart';
import '../Services/firestore_service.dart';
import '../helpers/image_upload.dart';

class ProfileViewModel extends GetxController {
  var firebaseUser = myUser().obs;
  final AuthUser authUser = AuthUser();

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  // Function to upload profile picture
  Future<UploadResponse> updateProfilePic(File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await FileUpload.uploadFile(imageFile);
    }
    try {
      await FirestoreService.updateProfilePic(authUser.uid, imageUrl!);
      fetchUserData(); // Fetch updated user data after profile picture is uploaded
      return UploadResponse(success: true, message: imageUrl);
    } catch (e) {
      print(e);
      return UploadResponse(success: false, message: e.toString());
    }
  }

  // Function to fetch user data
  Future<void> fetchUserData() async {
    try {
      final fetchedUser = await FirestoreService.fetchUserData(authUser.uid);
      firebaseUser.value = fetchedUser!;
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<bool> updateUser(String name, String bio) async {
    try {
      await FirestoreService.updateUserProfile(
          uid: authUser.uid, name: name, bio: bio);
      firebaseUser.value.name = name;
      firebaseUser.value.bio = bio;
      update();
      return true;
    } catch (e) {
      print("Error updating user data: $e");
      return false;
    }
  }

  void followUser(posterId, posterUid) async {
    try {
      await FirestoreService.followUser(
          authUser.uid, authUser.email, posterId, posterUid);
      update();
    } catch (e) {
      print("Error following user: $e");
    }
  }
}
