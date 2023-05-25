import 'package:flutter/material.dart';
import 'package:helpdesk/providers/helpDeskProvider.dart';
import 'package:provider/provider.dart';
import 'screens/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HelpDeskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        ),
        // A widget which will be started on application startup
        home: LoginPage(),
      ),
    );
  }
}
