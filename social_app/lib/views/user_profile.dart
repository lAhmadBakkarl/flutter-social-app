import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:social_app/Models/auth_user.dart';
import 'package:social_app/Widgets/post.dart';
import 'package:social_app/view_models/home_view_model.dart';
import 'package:social_app/view_models/profile_view_model.dart';
import '../Constants/AppColors.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final ProfileViewModel profileController =
      Get.isRegistered<ProfileViewModel>()
          ? Get.find<ProfileViewModel>()
          : Get.put(ProfileViewModel());

  final HomeViewModel homeController = Get.put(HomeViewModel());
  final TextEditingController commentText = TextEditingController();
  var showPosts = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Obx(() {
            final postUser = profileController.appUser.value;
            final following = postUser.followersList.contains(AuthUser().email);
            final availableWidth = MediaQuery.sizeOf(context).width - 10;
            final availableHeight = MediaQuery.sizeOf(context).height - 10;

            // ignore: unnecessary_null_comparison
            if (postUser == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      postUser.profilePic != null &&
                              postUser.profilePic!.isNotEmpty
                          ? Container(
                              width: availableWidth * 0.13,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColors.greenColor,
                                  width: 1,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  postUser.profilePic!,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                          : Container(
                              width: availableWidth * 0.13,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColors.greenColor,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                              ),
                            ),
                      const SizedBox(width: 10),
                      Container(
                        width: availableWidth * 0.47,
                        child: Text(
                          postUser.name ?? postUser.email ?? "...",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      postUser.uid != AuthUser().uid
                          ? Container(
                              width: availableWidth * 0.27,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (following) {
                                    profileController.unfollowUser(
                                        postUser.email!, postUser.uid!);
                                  } else {
                                    profileController.followUser(
                                        postUser.email!, postUser.uid!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkGreyColor,
                                  shape: const StadiumBorder(),
                                  minimumSize: const Size(60, 25),
                                ),
                                child: Text(following ? "Unfollow" : "Follow",
                                    style: const TextStyle(
                                        color: AppColors.blackColor)),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text("${postUser.followersList.length} followers"),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(postUser.bio ?? "...",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.greenColor,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      //button for posts
                      Container(
                        width: availableWidth * 0.45,
                        child: ElevatedButton(
                          child: Text("posts",
                              style: TextStyle(color: AppColors.lightPrimary)),
                          onPressed: () async {
                            setState(() {
                              showPosts = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreyColor,
                            //square button
                            shape: const RoundedRectangleBorder(),
                            minimumSize: const Size(100, 50),
                          ),
                        ),
                      ),
                      Container(
                        width: availableWidth * 0.45,
                        child: ElevatedButton(
                          child: Text("followers",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            setState(() {
                              showPosts = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreyColor,
                            shape: const RoundedRectangleBorder(),
                            minimumSize: const Size(100, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                showPosts
                    ? Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: availableHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8,
                            itemCount: homeController.userPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final post = homeController.userPosts[index];
                              final user = profileController.firebaseUser.value;
                              return PostTile(
                                post: post,
                                user: user,
                                onFollow: () async {
                                  profileController.followUser(
                                      post.posterId, post.posterUid);
                                },
                                onLike: () {
                                  if (post.likesList
                                      .contains(AuthUser().email)) {
                                    homeController.unlikePost(post, AuthUser());
                                  } else {
                                    homeController.likePost(post, AuthUser());
                                  }
                                },
                                onComment: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Comment"),
                                      content: TextField(
                                        controller: commentText,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            commentText.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            homeController.commentPost(post,
                                                AuthUser(), commentText.text);
                                            commentText.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Comment"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: availableWidth,
                          height: availableHeight,
                          child: ListView.builder(
                            itemCount: postUser.followersList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(postUser.followersList[index]),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  postUser.uid == AuthUser().uid
                                      ? ElevatedButton(
                                          child: const Text("Unfollow"),
                                          onPressed: () async {
                                            profileController
                                                .unfollowUserFromList(
                                              postUser.followersList[index],
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.darkGreyColor,
                                            shape: const StadiumBorder(),
                                            minimumSize: const Size(60, 25),
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              );
                            },
                          ),
                        ),
                      )
              ],
            );
          }),
        ),
      ),
    );
  }
}
