import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/Models/my_user.dart';

import '../Constants/Constants.dart';
import '../Models/Post.dart';
import '../Models/auth_user.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollection);

  static CollectionReference posts =
      FirebaseFirestore.instance.collection(postsCollection);

  static Future<bool> createUser(String uid, String email) async {
    try {
      await users.doc(uid).set({
        'uid': uid,
        'email': email,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateUser(String uid, String name, String bio) async {
    try {
      await users.doc(uid).update({
        'name': name,
        'bio': bio,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> updateProfilePic(String uid, String profilePic) async {
    try {
      await users.doc(uid).update({
        'profilePic': profilePic,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<myUser?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userDocument = await users.doc(uid).get();
      if (userDocument.exists) {
        print("User exists : $userDocument");
        return myUser.fromJson(userDocument.data() as Map<String, dynamic>);
      } else {
        print("User doesn't exist");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> updateUserProfile(
      {required String uid, required String name, required String bio}) async {
    try {
      await users.doc(uid).update({
        'name': name,
        'bio': bio,
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createPost(Post post) async {
    try {
      await posts.doc(post.id).set(post.toJson());
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Post>> fetchPosts(List<String> followedUserIds) async {
    try {
      final snapshot =
          await posts.where("posterId", whereIn: followedUserIds).get();

      return snapshot.docs
          .map((e) => Post.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> followUser(
      String uid, String email, posterId, posterUid) async {
    await users.doc(uid).update({
      'followingList': FieldValue.arrayUnion([posterId]),
    });
    await users.doc(posterUid).update({
      'followersList': FieldValue.arrayUnion([email]),
    });
  }

  static Future<void> likePost(Post post, AuthUser user) async {
    try {
      await posts.doc(post.id).update({
        'likes': post.likes + 1,
        'likesList': FieldValue.arrayUnion([user.email]),
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Post>> fetchAllPosts() async {
    try {
      final snapshot = await posts.get();
      return snapshot.docs
          .map((e) => Post.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
