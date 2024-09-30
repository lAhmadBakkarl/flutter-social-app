class myUser {
  String? uid;
  String? name;
  String? email;
  String? bio;
  String? profilePic;
  int followers = 0;
  List<String> followersList = [];
  int following = 0;
  List<String> followingList = [];
  List<String> posts = [];

  myUser({
    this.name,
    this.email,
    this.uid,
    this.bio,
    this.profilePic,
    this.followers = 0,
    this.followersList = const [],
    this.following = 0,
    this.followingList = const [],
    this.posts = const [],
  });

  factory myUser.fromJson(Map<String, dynamic> json) {
    return myUser(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      profilePic: json['profilePic'] as String? ?? '',
      followers: json['followers'] as int? ?? 0,
      followersList: List<String>.from(json['followersList'] ?? []),
      following: json['following'] as int? ?? 0,
      followingList: List<String>.from(json['followingList'] ?? []),
      posts: List<String>.from(json['posts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePic': profilePic,
      'followers': followers,
      'followersList': followersList,
      'following': following,
      'followingList': followingList,
      'posts': posts
    };
  }
}
