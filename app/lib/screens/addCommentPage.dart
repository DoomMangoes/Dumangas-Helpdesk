import 'package:flutter/material.dart';
import 'package:helpdesk/models/comment.dart';
import 'package:helpdesk/models/report.dart';
import 'package:provider/provider.dart';

import '../providers/helpDeskProvider.dart';

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({super.key});

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  late final TextEditingController _commentController;

  @override
  void initState() {
    _commentController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();

    super.dispose();
  }

  void addComment(
      Report reportItem, String currentUser, String currentUserType) {
    final String comment = _commentController.text;

    if (comment.isNotEmpty) {
      final newComment = Comment(
          commentBody: comment,
          originalPoster: currentUser,
          userType: currentUserType,
          parentID: reportItem.reportID,
          date: DateTime.now());

      context.read<HelpDeskProvider>().addComment(reportItem, newComment);

      Navigator.of(context).pop();
    } else {
      alert();
    }
  }

  void alert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("All fields must be filled!",
                  textAlign: TextAlign.center),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Center(child: Text("Back"))),
              ]);
        });
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                maxLines: 2,
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: "Comment:",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  addComment(reportItem, currentUser, currentUserType);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Add Comment",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
