import 'package:flutter/material.dart';
import 'package:ombre/pages/home_page.dart';
import 'package:ombre/pages/secret_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecretStatusChecker extends StatelessWidget {
  const SecretStatusChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkSecretStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.data == false) {
            // First sign-in, navigate to the secret setup page
            return const SecretPage();
          } else {
            // Not the first sign-in, navigate to the home screen
            return const HomePage();
          }
        }
      },
    );
  }

  Future<bool> _checkSecretStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool secretSet = preferences.getBool('secretSet') ?? false;
    return secretSet;
  }
}
