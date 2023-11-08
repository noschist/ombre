import 'package:flutter/material.dart';
import 'package:ombre/services/auth_methods.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthMethods>().user;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Text("Name :  ${user.displayName!}"),
          Text("Email :  ${user.email!}"),
          Text("UID :  ${user.uid}"),
          Text("Provider :  ${user.providerData[0].providerId}")
        ],
      )),
    );
  }
}
