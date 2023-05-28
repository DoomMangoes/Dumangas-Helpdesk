import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../models/report.dart';
import '../providers/helpDeskProvider.dart';
import '../screens/reportPage.dart';

class ReportPostWidget extends StatelessWidget {
  final Report reportItem;
  const ReportPostWidget({
    super.key,
    required this.reportItem,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HelpDeskProvider>(context);
    final UnmodifiableListView<Comment> comments = provider.comments;

    List<Comment> commentList = comments
        .where((comment) => comment.parentID == reportItem.reportID)
        .toList();

    return InkWell(
      onTap: () {
        context.read<HelpDeskProvider>().setCurrentReport(reportItem.reportID);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReportPage()));
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
        ),
        height: 120,
        width: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, bottom: 8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reportItem.originalPoster +
                          " (" +
                          reportItem.userType +
                          ")",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(reportItem.date),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  reportItem.reportTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reportItem.category,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      "Comments: " + commentList.length.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
