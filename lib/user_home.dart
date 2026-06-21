import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'free_guessing_forum.dart';
import 'login_page.dart';

class UserHome extends StatelessWidget {
  final String username;

  const UserHome(
    this.username, {
    super.key,
  });

  Future<void> logout(
    BuildContext context,
  ) async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(
        builder: (_) =>
        const LoginPage(),
      ),

      (route) => false,

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
        Colors.black,

        title: Text(
          "Welcome $username",
        ),

        actions: [

          IconButton(

            onPressed: () {
              logout(context);
            },

            icon: const Icon(
              Icons.logout,
            ),

          ),

        ],

      ),

      body: FreeGuessingForum(
        username: username,
      ),

    );
  }
}
