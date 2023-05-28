import 'package:flutter/material.dart';
import 'package:helpdesk/models/category.dart';
import 'package:helpdesk/models/report.dart';
import 'package:uuid/uuid.dart';
import '../models/comment.dart';
import '../models/user.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HelpDeskProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> _admins = [];
  List<Category> _categories = [];
  List<Report> _reports = [];
  List<Comment> _comments = [];

  String _currentUser = "Test";
  String _currentUserType = "Test";
  String _currentCategory = "All";
  String _reportCategory = "General";
  String _currentReportID = "";
  String _userFilter = "";

  //Read only view
  UnmodifiableListView<User> get users => UnmodifiableListView(_users);
  UnmodifiableListView<User> get admins => UnmodifiableListView(_admins);
  UnmodifiableListView<Report> get reports => UnmodifiableListView(_reports);
  UnmodifiableListView<Comment> get comments => UnmodifiableListView(_comments);
  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  Report get currentReport =>
      _reports.firstWhere((report) => report.reportID == _currentReportID,
          orElse: () {
        return Report(
            reportID: const Uuid().v4(),
            reportTitle: "",
            reportBody: "",
            originalPoster: "",
            userType: "",
            category: "",
            date: DateTime.now());
      });

  String get currentUser => _currentUser;
  String get currentUserType => _currentUserType;
  String get currentCategory => _currentCategory;
  String get reportCategory => _reportCategory;
  String get currentReportID => _currentReportID;
  String get userFilter => _userFilter;

  HelpDeskProvider() {
    this.fetchUsers();
    this.fetchAdmins();
    this.fetchCategories();
    this.fetchReports();
    this.fetchComments();
  }

  void fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/user/'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      _users = jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }

    notifyListeners();
  }

  void fetchAdmins() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/adminuser/'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      _admins = jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch admin users');
    }

    notifyListeners();
  }

  void fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/category/'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      _categories = jsonList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }

    notifyListeners();
  }

  void fetchReports() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/report/'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      _reports = jsonList.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch reports');
    }

    notifyListeners();
  }

  void fetchComments() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/comment/'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      _comments = jsonList.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch comments');
    }

    notifyListeners();
  }

  Future<void> register(User user) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final url = 'http://127.0.0.1:8000/api/user/';

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(user.toJson()));

    if (response.statusCode == 201) {
      fetchUsers();
    }

    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final url = 'http://127.0.0.1:8000/api/category/';

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(category.toJson()));

    if (response.statusCode == 201) {
      fetchCategories();
    }

    notifyListeners();
  }

  void login(String currentUser, String currentUserType) {
    _currentUser = currentUser;
    _currentUserType = currentUserType;
    notifyListeners();
  }

  void changeCurrentCategoy(String currentCategory) {
    _currentCategory = currentCategory;
    notifyListeners();
  }

  void changeReportCategoy(String reportCategory) {
    _reportCategory = reportCategory;
    notifyListeners();
  }

  void setCurrentReport(String currentReportID) {
    _currentReportID = currentReportID;

    notifyListeners();
  }

  void addReport(Report report) {
    _reports.add(report);
    notifyListeners();
  }

  void addComment(Report report, Comment comment) {
    notifyListeners();
  }

  void changeUserFilter(String userFilter) {
    _userFilter = userFilter;
    notifyListeners();
  }
}
