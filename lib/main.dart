import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/SplashScreen/presentation/pages/splashscreen.dart';
import 'core/provider/validation_provider.dart';
import 'features/Authentication/presentation/provider/authentication_provider.dart';
import 'injection.dart' as di;
import 'features/Authentication/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ValidationProvider()),
        ChangeNotifierProvider(
          create: (context) => di.myInjection<AuthenticationProvider>(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
