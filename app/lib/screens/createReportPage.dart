import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:helpdesk/models/report.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/helpDeskProvider.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void addReport(String currentUser, String userType, String category) {
    final String title = _titleController.text;
    final String body = _bodyController.text;

    if (title.isNotEmpty && body.isNotEmpty) {
      final newReport = Report(
          reportTitle: title,
          reportBody: body,
          originalPoster: currentUser,
          userType: userType,
          category: category,
          date: DateTime.now());

      context.read<HelpDeskProvider>().addReport(newReport);

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
    final UnmodifiableListView<Category> categories =
        context.select<HelpDeskProvider, UnmodifiableListView<Category>>(
      (provider) => provider.categories,
    );

    final List<Category> selectCategories =
        categories.where((category) => category.categoryName != "All").toList();

    String dropDownValue = context.select<HelpDeskProvider, String>(
      (provider) => provider.reportCategory,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                maxLines: 1,
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title:",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Text("Body:"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: TextField(
                maxLines: 10,
                controller: _bodyController,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropDownValue,
                      items: selectCategories.map((Category category) {
                        return DropdownMenuItem<String>(
                          value: category.categoryName,
                          child: Text(category.categoryName),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        context
                            .read<HelpDeskProvider>()
                            .changeReportCategoy(value!);
                      },
                      underline: SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                addReport(currentUser, currentUserType, dropDownValue);
              },
              child: Text("Post Report"),
            ),
          ],
        ),
      ),
    );
  }
}
