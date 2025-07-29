import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/provider/validation_provider.dart';
import 'features/Authentication/presentation/pages/login_page.dart';
import 'injection.dart';

void main() async {
  await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ValidationProvider()),
      ],
      child: MaterialApp(home: LoginPage()),
    );
  }
}
