import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/auth_user.dart';

class FileUpload {
  static Future<String> uploadFile(File postFile) async {
    final AuthUser authUser = AuthUser();
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('users_images/${authUser.uid}');

      // Start the upload task
      final uploadFile = storageRef.putFile(postFile);

      // Monitor upload progress
      uploadFile.snapshotEvents.listen((fileSnapshot) {
        final progress =
            fileSnapshot.bytesTransferred / fileSnapshot.totalBytes;
        print("Upload progress: ${progress * 100}%");
      });

      // Wait for the upload to complete
      final fileSnapshot = await uploadFile.whenComplete(() {});

      // Get the download URL
      final downloadUrl = await fileSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e");
      rethrow;
    }
  }
}
