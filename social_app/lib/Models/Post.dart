import 'package:social_app/Models/comment.dart';

class Post {
  String id;
  String? text;
  int likes = 0;
  List<String> likesList = [];
  int comments = 0;
  List<Comment> commentsList = [];
  String? postPhoto;
  String? postVideo;
  String posterId;
  String posterUid;
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
      required this.posterUid,
      required this.posterId,
      required this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      text: json['text'] as String,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      postPhoto: json['postPhoto'] as String?,
      postVideo: json['postVideo'] as String?,
      posterId: json['posterId'] as String,
      date: json['date'] as String,
      posterUid: json['posterUid'] as String,
      likesList: (json['likesList'] as List<dynamic>).cast<String>(),
      commentsList: (json['commentsList'] as List<dynamic>)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
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
      'posterUid': posterUid,
      'date': date
    };
  }
}
