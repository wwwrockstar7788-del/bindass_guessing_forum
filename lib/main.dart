import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bindass_guessing_forum/firebase_options.dart';
import 'package:bindass_guessing_forum/splash_screen.dart';
import 'admin_login_page.dart';
import 'login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //
      //   "/admin": (context) =>
      //   const AdminLoginPage(),
      //
      // },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E222D), // Deep dark background
      ),
      home: SplashScreen(),
    );
  }
}
