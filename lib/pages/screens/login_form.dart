import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ombre/pages/register_page.dart';
import 'package:ombre/services/auth_methods.dart';
import 'package:ombre/util/google_btn.dart';
import 'package:ombre/util/primarybtn_filled.dart';
import 'package:ombre/util/slidein_anim.dart';
import 'package:ombre/util/textbtn_login_signup.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _passwordEditController = TextEditingController();
  final TextEditingController _emailEditController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordEditController.dispose();
    _emailEditController.dispose();
    super.dispose();
  }

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Log In",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
          ),
          SizedBox(
            height: 40.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailEditController,
            enableSuggestions: false,
            cursorColor: const Color(0xFF2b38a4),
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.words,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value!)) {
                return null;
              } else {
                return "Please fill in a valid email id";
              }
            },
            style: const TextStyle(color: Color(0xFF2b38a4)),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
              ),
              hintText: "Email ID",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4D4D4)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2b38a4)),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA42424)),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
              textInputAction: TextInputAction.done,
              controller: _passwordEditController,
              style: const TextStyle(color: Color(0xFF2b38a4)),
              obscureText: !_isPasswordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "Please fill in your password";
                }
              },
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                  splashRadius: 1,
                  icon: _isPasswordVisible
                      ? const Icon(Icons.visibility_outlined,
                          color: Color(0xFF2b38a4))
                      : const Icon(Icons.visibility_off_outlined,
                          color: Color(0xFFBDBDBD)),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD4D4D4)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2b38a4)),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA42424)),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFA42424)),
                ),
              )),
          SizedBox(
            height: 50.h,
          ),
          primaryBtnFilled(logInUser, "Login"),
          SizedBox(
            height: 30.h,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  // indent: 20.0,
                  endIndent: 12.0,
                  thickness: 1,
                ),
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Divider(
                  indent: 12.0,
                  // endIndent: 20.0,
                  thickness: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          googleBtn(context, isLoginMsg: true),
          SizedBox(
            height: 30.h,
          ),
          textBtnLoginOrSignUp(() {
            Navigator.of(context)
                .pushReplacement(createRoute(const RegisterPage()));
          })
        ],
      ),
    );
  }

  void logInUser() async {
    if (_loginFormKey.currentState!.validate()) {
      AuthStatRes res = await context.read<AuthMethods>().logInWithEmail(
          email: _emailEditController.text.trim(),
          password: _passwordEditController.text.trim(),
          context: context);
      if ((res == AuthStatRes.secretPend || res == AuthStatRes.success) &&
          context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
