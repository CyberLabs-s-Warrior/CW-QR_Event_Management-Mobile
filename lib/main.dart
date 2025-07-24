import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/Authentication/presentation/pages/login_page.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Authentication',
        home: LoginPage(),
    );
  }
}
