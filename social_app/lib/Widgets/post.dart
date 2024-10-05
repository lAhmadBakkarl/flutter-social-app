import 'package:flutter/material.dart';
import 'package:social_app/Models/my_user.dart';
import 'package:social_app/Widgets/comment.dart';
import '../Constants/AppColors.dart';
import '../Models/Post.dart';

class PostTile extends StatefulWidget {
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
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  var isLiked = false;
  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.sizeOf(context).width - 20;
    return Card(
        child: Column(
      children: [
        Row(children: [
          if (widget.user != null &&
              widget.user!.profilePic != null &&
              widget.user!.profilePic!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.network(
                  widget.user!.profilePic!,
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: availableWidth * 0.15,
                child: IconButton(
                  icon: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                  onPressed: widget.onUserTap,
                ),
              ),
            ),
          Container(
              width: availableWidth * 0.6,
              child: Row(
                children: [
                  Text(widget.post.posterId),
                  widget.user!.followingList.contains(widget.post.posterId)
                      ? const Icon(Icons.check_box, color: Colors.green)
                      : IconButton(
                          onPressed: widget.onFollow,
                          icon: Icon(Icons.add_box_rounded)),
                ],
              )),
          Container(width: availableWidth * 0.2, child: Text(widget.post.date)),
        ]),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(widget.post.text ?? ''),
          ],
        ),

        const SizedBox(
          height: 10,
        ),
        if (widget.post.postPhoto != null && widget.post.postPhoto!.isNotEmpty)
          Image.network(
            widget.post.postPhoto!,
            fit: BoxFit.cover,
            width: 375,
            height: 300,
          ),
        const SizedBox(
          height: 25,
        ),
        if (widget.post.postVideo != null && widget.post.postVideo!.isNotEmpty)
          Image.network(
            widget.post.postVideo!,
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
            isLiked
                ? IconButton(
                    //setState and use onLike function
                    onPressed: () {
                      setState(() {
                        isLiked = false;
                      });
                      widget.onLike!();
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked = true;
                      });
                      widget.onLike!();
                    },
                    icon: const Icon(
                      Icons.favorite_border,
                      color: AppColors.blackColor,
                    )),
            Text(widget.post.likesList.length.toString()),
            const SizedBox(
              width: 200,
            ),
            IconButton(
                onPressed: widget.onComment,
                icon: const Icon(
                  Icons.comment,
                  color: AppColors.blackColor,
                )),
            Text(widget.post.commentsList.length.toString()),
          ],
        ),
        //ListView to list the comments
        if (widget.post.commentsList.isNotEmpty) const Divider(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.post.commentsList.length,
            itemBuilder: (context, index) {
              return CommentTile(commentPost: widget.post.commentsList[index]);
            }),
      ],
    ));
  }
}
