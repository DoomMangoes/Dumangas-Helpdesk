import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../models/report.dart';
import '../providers/helpDeskProvider.dart';
import 'commentItemWidget.dart';

class CommentListWidget extends StatelessWidget {
  const CommentListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Report reportItem = context.select<HelpDeskProvider, Report>(
      (provider) => provider.currentReport,
    );
    final provider = Provider.of<HelpDeskProvider>(context);
    final UnmodifiableListView<Comment> comments = provider.comments;

    List<Comment> commentList = comments
        .where((comment) => comment.parentID == reportItem.reportID)
        .toList();

    return comments.isEmpty
        ? Center(
            child: Text("No Comments"),
          )
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: commentList.length,
            itemBuilder: (BuildContext context, int index) {
              return CommentItemWidget(
                commentItem: commentList[index],
              );
            });
  }
}
