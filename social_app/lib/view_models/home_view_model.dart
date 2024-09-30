import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/Post.dart';
import 'package:social_app/Models/auth_user.dart';
import 'package:social_app/helpers/image_upload.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import '../Services/firestore_service.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  var posts = <Post>[].obs;
  var allPosts = <Post>[].obs;
  final String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var isliked = false.obs;
  var likesList = <String>[].obs;
  var commentsList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final profileVM = Get.find<ProfileViewModel>();
    final user = profileVM.firebaseUser.value;

    // ignore: unnecessary_null_comparison
    if (user.followingList != null && user.followingList.isNotEmpty) {
      fetchFollowingsPosts(user.followingList);
    } else {
      profileVM.fetchUserData().then((_) {
        final updatedUser = profileVM.firebaseUser.value;
        // ignore: unnecessary_null_comparison
        if (updatedUser.followingList != null &&
            updatedUser.followingList.isNotEmpty) {
          fetchFollowingsPosts(updatedUser.followingList);
        }
      });
    }
    fetchAllPosts();
  }

  void createPost(
    String text,
    XFile? postPhoto,
    String? postVideo,
    String posterId,
    String posterUid,
  ) async {
    String? imageUrl;
    String? videoUrl;
    try {
      if (postPhoto != null) {
        imageUrl = await FileUpload.uploadFile(File(postPhoto.path));
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
        posterUid: posterUid,
        date: formattedDate,
        likes: 0,
        likesList: [],
        comments: 0,
        commentsList: [],
      );

      await FirestoreService.createPost(newPost);
      posts.add(newPost);
      posts.refresh();
      allPosts.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFollowingsPosts(followingList) async {
    try {
      final fetchedPosts = await FirestoreService.fetchPosts(followingList);
      posts.assignAll(fetchedPosts);
      posts.refresh();
      allPosts.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> likePost(Post post, AuthUser user) async {
    try {
      await FirestoreService.likePost(post, user);
      post.likesList.add(user.email);
      isliked.value = true;
      posts.refresh();
      allPosts.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unlikePost(Post post, AuthUser user) async {
    try {
      await FirestoreService.unlikePost(post, user);
      post.likesList.remove(user.email);
      isliked.value = false;
      posts.refresh();
      allPosts.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllPosts() async {
    try {
      final fetchedPosts = await FirestoreService.fetchAllPosts();
      allPosts.assignAll(fetchedPosts);
    } catch (e) {
      print(e);
    }
  }

  Future<void> commentPost(Post post, AuthUser authUser, String text) async {
    try {
      await FirestoreService.commentPost(post, authUser, text);
      posts.refresh();
      allPosts.refresh();
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
