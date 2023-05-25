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
    required this.commentBody,
    required this.originalPoster,
    required this.userType,
    required this.parentID,
    required this.date,
  }) : commentID = const Uuid().v4();

  @override
  bool operator ==(covariant Comment other) => commentID == other.commentID;

  @override
  int get hashCode => commentID.hashCode;
}
