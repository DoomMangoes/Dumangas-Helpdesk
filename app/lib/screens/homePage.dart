import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:helpdesk/widgets/reportListWidget.dart';
import 'package:helpdesk/widgets/reportPostWidget.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/user.dart';
import '../providers/helpDeskProvider.dart';
import 'createReportPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _filterController;

  @override
  void initState() {
    _filterController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _filterController.dispose();

    super.dispose();
  }

  void filterUser() {
    final String filter = _filterController.text;

    if (filter.isNotEmpty) {
      context.read<HelpDeskProvider>().changeUserFilter(filter);
    } else {
      alert();
    }
  }

  void clearFilter() {
    context.read<HelpDeskProvider>().changeUserFilter("");
  }

  void filterUserDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Filter posts by user:", textAlign: TextAlign.center),
              actions: <Widget>[
                TextField(
                  maxLines: 1,
                  controller: _filterController,
                  decoration: InputDecoration(
                    labelText: "Username:",
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterUser();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Center(child: Text("Filter User Posts"))),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        clearFilter();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Center(child: Text("Clear Filter"))),
                SizedBox(height: 10),
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

    String dropDownValue = context.select<HelpDeskProvider, String>(
      (provider) => provider.currentCategory,
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
        actions: [
          Container(
            width: 130,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropDownValue,
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.categoryName,
                  child: Text(category.categoryName),
                );
              }).toList(),
              onChanged: (String? value) {
                context.read<HelpDeskProvider>().changeCurrentCategoy(value!);
              },
              underline: SizedBox(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReportListWidget(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: currentUserType == "User"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateReportPage()));
              },
              child: const Icon(
                Icons.add,
              ),
            )
          : FloatingActionButton(
              onPressed: () {
                filterUserDialog();
              },
              child: const Icon(
                Icons.filter_alt,
              ),
            ),
    );
  }
}
