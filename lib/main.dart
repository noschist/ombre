import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ombre/firebase_options.dart';
import 'package:ombre/pages/home_page.dart';
import 'package:ombre/pages/onboarding_page.dart';
import 'package:ombre/services/auth_methods.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthMethods>(
          create: (_) => AuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthMethods>().authState,
            initialData: null)
      ],
      child: ScreenUtilInit(
        designSize: const Size(450, 975),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
            theme: ThemeData(
                textTheme: GoogleFonts.notoSansTextTheme(),
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: const Color(0xFF2b38a4))),
          );
        },
        child: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const HomePage();
    }
    return const OnboardingPage();
  }
}
