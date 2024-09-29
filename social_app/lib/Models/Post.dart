class Post {
  String id;
  String? text;
  int likes = 0;
  List<String> likesList = [];
  int comments = 0;
  List<String> commentsList = [];
  String? postPhoto;
  String? postVideo;
  String posterId;
  String date;

  Post(
      {required this.id,
      this.text,
      required this.likes,
      required this.likesList,
      required this.comments,
      required this.commentsList,
      this.postPhoto,
      this.postVideo,
      required this.posterId,
      required this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as String,
        text: json['text'] as String,
        likes: json['likes'] as int,
        likesList: json['likesList'] as List<String>,
        comments: json['comments'] as int,
        commentsList: json['commentsList'] as List<String>,
        postPhoto: json['postPhoto'] as String?,
        postVideo: json['postVideo'] as String?,
        posterId: json['posterId'] as String,
        date: json['date'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'likes': likes,
      'likesList': likesList,
      'comments': comments,
      'commentsList': commentsList,
      'postPhoto': postPhoto,
      'postVideo': postVideo,
      'posterId': posterId,
      'date': date
    };
  }
}
