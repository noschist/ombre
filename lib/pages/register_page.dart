import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/screens/register_form.dart';
import 'package:ombre/pages/screens/register_form_two.dart';
import 'package:ombre/util/logo_with_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userName = "", userPass = "";

  bool checkUserNameAndPass() {
    return userName.isEmpty && userPass.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: logoWithIcon(showText: true),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
          child: checkUserNameAndPass()
              ? RegisterForm(callback: (name, pass) {
                  setState(() {
                    userName = name;
                    userPass = pass;
                  });
                })
              : RegisterFormTwo(userName: userName, loginPass: userPass)),
    );
  }
}
