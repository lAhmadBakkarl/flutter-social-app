import 'package:flutter/material.dart';
import 'package:social_app/Models/my_user.dart';
import '../Constants/AppColors.dart';
import '../Models/Post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onFollow;
  final myUser? user;

  const PostTile(
      {super.key,
      required this.post,
      this.onLike,
      this.onComment,
      this.onFollow,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(children: [
          if (user != null &&
              user!.profilePic != null &&
              user!.profilePic!.isNotEmpty)
            ClipOval(
              child: Image.network(
                user!.profilePic!,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            )
          else
            const Icon(
              Icons.person,
              size: 50,
            ),
          const SizedBox(
            width: 10,
          ),
          Text(post.posterId),
          user!.followingList.contains(post.posterId)
              ? const Icon(Icons.check_box, color: Colors.green)
              : IconButton(
                  onPressed: onFollow, icon: Icon(Icons.add_box_rounded)),
          const SizedBox(width: 60),
          Text(post.date),
        ]),
        const SizedBox(
          height: 10,
        ),
        //make the text to the left, not centered
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(post.text ?? 'No content'),
          ],
        ),

        const SizedBox(
          height: 10,
        ),
        if (post.postPhoto != null && post.postPhoto!.isNotEmpty)
          Image.network(
            post.postPhoto!,
            fit: BoxFit.cover,
            width: 375,
            height: 300,
          ),
        const SizedBox(
          height: 25,
        ),
        if (post.postVideo != null && post.postVideo!.isNotEmpty)
          Image.network(
            post.postVideo!,
            fit: BoxFit.cover,
            width: 300,
            height: 300,
          ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            IconButton(
                onPressed: onLike,
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
            Text(post.likes.toString()),
            const SizedBox(
              width: 200,
            ),
            IconButton(
                onPressed: onComment,
                icon: const Icon(
                  Icons.comment,
                  color: AppColors.blackColor,
                )),
            Text(post.comments.toString()),
          ],
        )
      ],
    ));
  }
}
