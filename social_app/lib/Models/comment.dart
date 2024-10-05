import 'package:social_app/Models/my_user.dart';

class Comment {
  final String id;
  final myUser user;
  final String comment;
  final String date;
  Comment({
    required this.id,
    required this.user,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'user': user.toJson() ?? {},
      'comment': comment ?? '',
      'date': date ?? '',
    };
  }

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: myUser.fromJson(json['user']),
      comment: json['comment'],
      date: json['date'],
    );
  }
}
