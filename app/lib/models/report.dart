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

  Report({
    required this.reportID,
    required this.reportTitle,
    required this.reportBody,
    required this.originalPoster,
    required this.userType,
    required this.category,
    required this.date,
  });

  @override
  bool operator ==(covariant Report other) => reportID == other.reportID;

  @override
  int get hashCode => reportID.hashCode;

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportID: json['reportID'],
      reportTitle: json['reportTitle'],
      reportBody: json['reportBody'],
      originalPoster: json['originalPoster'],
      userType: json['userType'],
      category: json['category'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'reportID': reportID,
        'reportTitle': reportTitle,
        'reportBody': reportBody,
        'originalPoster': originalPoster,
        'userType': userType,
        'category': category,
        'date': date,
      };
}
