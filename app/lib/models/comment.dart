import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Comment {
  String commentID;
  String commentBody;
  String originalPoster;
  String userType;
  String parentID;
  DateTime date;

  Comment({
    required this.commentID,
    required this.commentBody,
    required this.originalPoster,
    required this.userType,
    required this.parentID,
    required this.date,
  });

  @override
  bool operator ==(covariant Comment other) => commentID == other.commentID;

  @override
  int get hashCode => commentID.hashCode;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentID: json['commentID'],
      commentBody: json['commentBody'],
      originalPoster: json['originalPoster'],
      userType: json['userType'],
      parentID: json['parentID'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'commentID': commentID,
        'commentBody': commentBody,
        'originalPoster': originalPoster,
        'userType': userType,
        'parentID': parentID,
        'date': date.toIso8601String().substring(0, 10),
      };
}
