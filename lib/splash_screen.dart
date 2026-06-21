import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'user_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startApp();
  }

  Future<void> startApp() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    bool isLoggedIn =
        prefs.getBool("isLoggedIn") ?? false;

    String username =
        prefs.getString("username") ?? "";

    if(!mounted) return;

    if(isLoggedIn &&
        username.isNotEmpty){

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>
              UserHome(username),

        ),

      );

    } else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>
          const LoginPage(),

        ),

      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xff111111),

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Image.asset(
              "assets/khel.jpeg",
              height: 120,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(

              "BINDASS GUESSING FORUM",

              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight:
                FontWeight.bold,
              ),

            ),

            const SizedBox(
              height: 20,
            ),

            const CircularProgressIndicator(),

          ],

        ),

      ),

    );
  }
}
