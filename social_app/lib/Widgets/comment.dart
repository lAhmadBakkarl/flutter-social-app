import 'package:flutter/material.dart';
import '../Models/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment commentPost;

  const CommentTile({Key? key, required this.commentPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // comment view that shows the user profile pic, name and comment
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          commentPost.user.profilePic != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(commentPost.user.profilePic!),
                )
              : Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(Icons.person, size: 30),
                ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentPost.user.name ?? commentPost.user.email!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(commentPost.comment),
            ],
          ),
        ],
      ),
    );
  }
}
