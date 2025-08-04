import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../SplashScreen/presentation/pages/splashscreen.dart';

import '../../../Authentication/presentation/provider/authentication_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return Center(
            child: Column(
              children: [
                Text("This is Home"),
                TextButton(
                  onPressed: () async {
                    // action

                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Logout"),
                              ),
                            ],
                          ),
                    );


                    if (shouldLogout == true) {
                      await authProvider.logout();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => SplashScreen()),
                        (route) => false,
                      );
                    }
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
