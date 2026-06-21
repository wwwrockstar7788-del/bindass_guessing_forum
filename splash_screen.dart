import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:bindass_guessing_forum/login_page.dart';
import 'package:bindass_guessing_forum/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_login_page.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  final AppLinks appLinks = AppLinks();

  bool _navigated = false;

  StreamSubscription? _sub;

  Future<void> checkLoginAndNavigate() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    bool isLoggedIn =
        prefs.getBool("isLoggedIn") ?? false;

    String username =
        prefs.getString("username") ?? "";

    if (_navigated || !mounted) return;
    _navigated = true;

    if (isLoggedIn && username.isNotEmpty) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UserHome(username),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );

    }
  }

  Future<void> _handleDeepLink() async {

    try {

      final uri = await appLinks.getInitialLink();

      if (uri?.toString() == "khelbindass99://admin") {

        if (_navigated || !mounted) return;
        _navigated = true;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const AdminLoginPage(),
          ),
        );

        return;
      }

      // listen for live links
      _sub = appLinks.uriLinkStream.listen((uri) {

        if (uri.toString() == "khelbindass99://admin") {

          if (_navigated || !mounted) return;
          _navigated = true;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminLoginPage(),
            ),
          );

        }

      });

      await Future.delayed(const Duration(seconds: 3));
      await checkLoginAndNavigate();

      if (_navigated || !mounted) return;
      _navigated = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );

    } catch (e) {

      await Future.delayed(const Duration(seconds: 3));
      await checkLoginAndNavigate();

      if (_navigated || !mounted) return;
      _navigated = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _handleDeepLink();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Color(0xff000000),
              Color(0xff0d2b14),
              Color(0xff1b5e20),

            ],

          ),

        ),

        child: Stack(

          alignment: Alignment.center,

          children: [

            // TOP GOLD CIRCLE

            Positioned(

              top: -120,
              right: -80,

              child: Container(

                height: 280,
                width: 280,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: const Color(
                    0xffffc107,
                  ).withOpacity(0.12),

                ),

              ),

            ),

            // BOTTOM GOLD CIRCLE

            Positioned(

              bottom: -100,
              left: -60,

              child: Container(

                height: 240,
                width: 240,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: const Color(
                    0xffffd54f,
                  ).withOpacity(0.08),

                ),

              ),

            ),

            // MAIN CONTENT

            Center(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  // LOGO

                  Container(

                    height: 220,
                    width: 220,

                    padding:
                    const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      gradient: const LinearGradient(

                        colors: [

                          Color(0xffffd54f),
                          Color(0xffffb300),

                        ],

                      ),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.amber
                              .withOpacity(0.45),

                          blurRadius: 30,

                          spreadRadius: 5,

                        ),

                      ],

                    ),

                    child: Container(

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,

                        color: Colors.black,

                        border: Border.all(

                          color:
                          const Color(
                            0xffffd54f,
                          ),

                          width: 3,

                        ),

                      ),

                      child: ClipOval(

                        child: Image.asset(

                          "assets/khel.jpeg",

                          fit: BoxFit.cover,

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(height: 35),

                  // TITLE

                  ShaderMask(

                    shaderCallback: (bounds) {

                      return const LinearGradient(

                        colors: [

                          Color(0xfffff8dc),
                          Color(0xffffc107),

                        ],

                      ).createShader(bounds);

                    },

                    child: const Text(

                      "BINDASS GUESSING FORUM",

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 34,

                        letterSpacing: 2,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                  ),

                  const SizedBox(height: 10),

                  const Text(

                    "B G F",

                    style: TextStyle(

                      color: Colors.white70,

                      fontSize: 15,

                      letterSpacing: 3,

                      fontWeight: FontWeight.w600,

                    ),

                  ),

                  const SizedBox(height: 50),

                  const CircularProgressIndicator(

                    color: Color(0xffffc107),

                    strokeWidth: 3,

                  ),

                  const SizedBox(height: 18),

                  const Text(

                    "Loading...",

                    style: TextStyle(

                      color: Colors.white70,

                      fontSize: 15,

                    ),

                  ),

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }
  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

}