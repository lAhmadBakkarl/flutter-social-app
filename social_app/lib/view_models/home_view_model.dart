import 'dart:io';

import 'package:get/get.dart';
import 'package:social_app/Models/Post.dart';
import 'package:social_app/helpers/image_upload.dart';

import '../Services/firestore_service.dart';

class HomeViewModel extends GetxController {
  List<Post> posts = [];
  int likes = 0;
  int comments = 0;
  List<String> likesList = [];
  List<String> commentsList = [];
  void createPost(
    String text,
    String? postPhoto,
    String? postVideo,
    String posterId,
  ) async {
    String? imageUrl;
    String? videoUrl;
    try {
      if (postPhoto != null) {
        imageUrl = await FileUpload.uploadFile(File(postPhoto));
      }
      if (postVideo != null) {
        videoUrl = await FileUpload.uploadFile(File(postVideo));
      }

      final newPost = Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          postPhoto: imageUrl ?? "",
          postVideo: videoUrl ?? "",
          posterId: posterId,
          date: DateTime.now().toString(),
          likes: likes,
          likesList: likesList,
          comments: comments,
          commentsList: commentsList);

      await FirestoreService.createPost(newPost);
      posts.add(newPost);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPosts() async {
    try {
      final fetchedPosts = await FirestoreService.fetchPosts();
      posts = fetchedPosts;
      update();
    } catch (e) {
      print(e);
    }
  }
}
