import 'dart:io';
import 'package:get/get.dart';
import 'package:social_app/Models/my_user.dart';
import 'package:social_app/Models/upload_response.dart';
import '../Models/auth_user.dart';
import '../Services/firestore_service.dart';
import '../helpers/image_upload.dart';

class ProfileViewModel extends GetxController {
  myUser? firebaseUser;
  AuthUser authUser = AuthUser();

  // Function to upload profile picture
  Future<UploadResponse> updateProfilePic(File? imageFile) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await ImageUpload.uploadImage(imageFile);
    }
    try {
      await FirestoreService.updateProfilePic(authUser.uid, imageUrl!);

      if (firebaseUser != null) {
        firebaseUser!.profilePic = imageUrl;
      }

      update();
      return UploadResponse(success: true, message: imageUrl);
    } catch (e) {
      print(e);
      return UploadResponse(success: false, message: e.toString());
    }
  }

  Future<myUser?> fetchUserData() async {
    try {
      // Fetch the user object from FirestoreService and assign it to firebaseUser
      firebaseUser = await FirestoreService.fetchUserData(authUser.uid);

      if (firebaseUser != null) {
        print("User fetched: ${firebaseUser!.name}");
        update();
        return firebaseUser;
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<bool> updateUser(String name, String bio) async {
    try {
      await FirestoreService.updateUserProfile(
          uid: authUser.uid, name: name, bio: bio);
      if (firebaseUser != null) {
        firebaseUser!.name = name;
        firebaseUser!.bio = bio;
        update();
        return true;
      }
      return false;
    } catch (e) {
      print("Error updating user data: $e");
      return false;
    }
  }
}
