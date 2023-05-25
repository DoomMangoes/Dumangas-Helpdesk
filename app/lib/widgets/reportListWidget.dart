import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:helpdesk/models/report.dart';
import 'package:helpdesk/widgets/reportPostWidget.dart';
import 'package:provider/provider.dart';

import '../providers/helpDeskProvider.dart';

class ReportListWidget extends StatelessWidget {
  const ReportListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HelpDeskProvider>(context);
    final UnmodifiableListView<Report> reportItems = provider.reports;
    String currentCategory = context.select<HelpDeskProvider, String>(
      (provider) => provider.currentCategory,
    );
    String userFilter = context.select<HelpDeskProvider, String>(
      (provider) => provider.userFilter,
    );

    List<Report> reportList = currentCategory == "All"
        ? reportItems.toList()
        : reportItems
            .where((report) => report.category == currentCategory)
            .toList();

    reportList = userFilter == ""
        ? reportList
        : reportList
            .where((report) => report.originalPoster == userFilter)
            .toList();

    return reportItems.isEmpty
        ? Center(
            child: Text("No posts"),
          )
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: reportList.length,
            itemBuilder: (BuildContext context, int index) {
              return ReportPostWidget(
                reportItem: reportList[index],
              );
            });
  }
}
