import 'package:helpdesk/models/comment.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Report {
  String reportID;
  String reportTitle;
  String reportBody;
  String originalPoster;
  String userType;
  String category;
  DateTime date;
  List<Comment> comments;

  Report({
    required this.reportTitle,
    required this.reportBody,
    required this.originalPoster,
    required this.userType,
    required this.category,
    required this.date,
  })  : reportID = const Uuid().v4(),
        comments = [];

  @override
  bool operator ==(covariant Report other) => reportID == other.reportID;

  @override
  int get hashCode => reportID.hashCode;
}
