class myUser {
  String? name;
  String? email;
  String userName;
  String? bio;
  String? profilePic;
  int followers = 0;
  List<String> followersList = [];
  int following = 0;
  List<String> followingList = [];
  List<String> posts = [];
  List<String> likes = [];
  List<String> comments = [];

  myUser(
      {this.name,
      required this.email,
      required this.userName,
      this.bio,
      this.profilePic,
      this.followers = 0,
      this.followersList = const [],
      this.following = 0,
      this.followingList = const [],
      this.posts = const [],
      this.likes = const [],
      this.comments = const []});

  factory myUser.fromJson(Map<String, dynamic> json) {
    return myUser(
      userName: json['userName'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      profilePic: json['profilePic'] as String? ?? '',
      followers: json['followers'] as int,
      followersList: json['followersList'] as List<String>,
      following: json['following'] as int,
      followingList: json['followingList'] as List<String>,
      posts: json['posts'] as List<String>,
      likes: json['likes'] as List<String>,
      comments: json['comments'] as List<String>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePic': profilePic,
      'followers': followers,
      'followersList': followersList,
      'following': following,
      'followingList': followingList,
      'posts': posts,
      'likes': likes,
      'comments': comments
    };
  }
}
