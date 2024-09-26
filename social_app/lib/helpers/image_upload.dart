import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/auth_user.dart';

class ImageUpload {
  static Future<String> uploadImage(File imageFile) async {
    final AuthUser authUser = AuthUser();
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('users_images/${authUser.uid}');

      // Start the upload task
      final uploadImage = storageRef.putFile(imageFile);

      // Monitor upload progress
      uploadImage.snapshotEvents.listen((imageSnapshot) {
        final progress =
            imageSnapshot.bytesTransferred / imageSnapshot.totalBytes;
        print("Upload progress: ${progress * 100}%");
      });

      // Wait for the upload to complete
      final imageSnapshot = await uploadImage.whenComplete(() {});

      // Get the download URL
      final downloadUrl = await imageSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      rethrow;
    }
  }
}
