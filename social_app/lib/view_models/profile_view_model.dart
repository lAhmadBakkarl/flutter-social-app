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
  var isUploading = false.obs;
  var appUser = myUser().obs;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<UploadResponse> updateProfilePic(File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      isUploading.value = true;
      imageUrl = await FileUpload.uploadFile(imageFile, false);
      isUploading.value = false;
    }
    try {
      await FirestoreService.updateProfilePic(authUser.uid, imageUrl!);
      firebaseUser.update((user) {
        user?.profilePic = imageUrl;
      });
      return UploadResponse(success: true, message: imageUrl);
    } catch (e) {
      print(e);
      return UploadResponse(success: false, message: e.toString());
    }
  }

  Future<void> fetchUserData() async {
    try {
      final fetchedUser = await FirestoreService.fetchUserData(authUser.uid);

      if (fetchedUser != null) {
        firebaseUser.value = fetchedUser;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> fetchUser(String uid) async {
    try {
      final fetchedUser = await FirestoreService.fetchUserData(uid);
      if (fetchedUser != null) {
        appUser.value = fetchedUser;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<bool> updateUser(String name, String bio) async {
    try {
      await FirestoreService.updateUserProfile(
          uid: authUser.uid, name: name, bio: bio);
      firebaseUser.update((user) {
        user?.name = name;
        user?.bio = bio;
      });
      return true;
    } catch (e) {
      print("Error updating user data: $e");
      return false;
    }
  }

  void followUser(String posterId, String posterUid) async {
    try {
      await FirestoreService.followUser(
          authUser.uid, authUser.email, posterId, posterUid);
      fetchUserData();
      fetchUser(posterUid);
      firebaseUser.refresh();
      appUser.refresh();
    } catch (e) {
      print("Error following user: $e");
    }
  }

  void unfollowUser(String postedId, String posterUid) {
    try {
      FirestoreService.unfollowUser(
          authUser.uid, authUser.email, postedId, posterUid);
      fetchUserData();
      fetchUser(posterUid);
      firebaseUser.refresh();
      appUser.refresh();
    } catch (e) {
      print("Error unfollowing user: $e");
    }
  }

  void unfollowUserFromList(String followedEmail) {
    try {
      FirestoreService.unfollowUserFromList(
          authUser.uid, authUser.email, followedEmail);
      fetchUserData();
    } catch (e) {
      print("Error unfollowing user: $e");
    }
  }
}
