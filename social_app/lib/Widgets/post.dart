import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/my_user.dart';
import '../Constants/AppColors.dart';
import '../Models/Post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final myUser? user;

  const PostTile(
      {super.key,
      required this.post,
      this.onLike,
      this.onComment,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(children: [
          user!.profilePic != null && user!.profilePic!.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    user!.profilePic!,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                )
              : Icon(
                  Icons.person,
                  size: 200,
                ),
          SizedBox(
            width: 10,
          ),
          Text(user!.email)
        ]),
        Text(post.text!),
      ],
    ));
  }
}
