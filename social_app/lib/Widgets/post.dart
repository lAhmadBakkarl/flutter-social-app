import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:social_app/Models/my_user.dart';
import '../Constants/AppColors.dart';
import '../Models/Post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onFollow;
  final Function()? onUserTap;
  final myUser? user;

  const PostTile(
      {super.key,
      required this.post,
      this.onLike,
      this.onComment,
      this.onFollow,
      this.onUserTap,
      required this.user});

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.sizeOf(context).width - 20;
    return Card(
        child: Column(
      children: [
        Row(children: [
          // if (user != null &&
          //     user!.profilePic != null &&
          //     user!.profilePic!.isNotEmpty)
          //   ClipOval(
          //     child: Image.network(
          //       user!.profilePic!,
          //       fit: BoxFit.cover,
          //       width: 50,
          //       height: 50,
          //     ),
          //   )
          // else
          Container(
            width: availableWidth * 0.15,
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 50,
              ),
              onPressed: onUserTap,
            ),
          ),

          Container(
              width: availableWidth * 0.6,
              child: Row(
                children: [
                  Text(post.posterId),
                  user!.followingList.contains(post.posterId)
                      ? const Icon(Icons.check_box, color: Colors.green)
                      : IconButton(
                          onPressed: onFollow,
                          icon: Icon(Icons.add_box_rounded)),
                ],
              )),
          Container(width: availableWidth * 0.2, child: Text(post.date)),
        ]),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(post.text ?? ''),
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
            Text(post.likesList.length.toString()),
            const SizedBox(
              width: 200,
            ),
            IconButton(
                onPressed: onComment,
                icon: const Icon(
                  Icons.comment,
                  color: AppColors.blackColor,
                )),
            Text(post.commentsList.length.toString()),
          ],
        ),
        //ListView to list the comments
        if (post.commentsList.isNotEmpty) const Divider(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: post.commentsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(post.commentsList[index]),
              );
            }),
      ],
    ));
  }
}
