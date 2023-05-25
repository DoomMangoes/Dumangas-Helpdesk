import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helpdesk/widgets/commentListWidget.dart';
import 'package:helpdesk/widgets/reportPostViewWidget.dart';
import 'package:provider/provider.dart';
import '../models/report.dart';
import '../providers/helpDeskProvider.dart';
import 'addCommentPage.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({
    super.key,
  });

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int id = 0;

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String currentUser = context.select<HelpDeskProvider, String>(
      (provider) => provider.currentUser,
    );
    final String currentUserType = context.select<HelpDeskProvider, String>(
      (provider) => provider.currentUserType,
    );

    final Report reportItem = context.select<HelpDeskProvider, Report>(
      (provider) => provider.currentReport,
    );

    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Column(children: [
          Text(currentUser),
          Text(
            currentUserType,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13,
            ),
          )
        ]),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReportPostViewWidget(),
                SizedBox(height: 10),
                CommentListWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCommentPage()))
              .then(onGoBack);
        },
        child: const Icon(
          Icons.forum,
        ),
      ),
    );
  }
}
