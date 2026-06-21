import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'register_page.dart';
import 'forgot_password_page.dart';
import 'user_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> login() async {

    if(usernameController.text.isEmpty ||
        passwordController.text.isEmpty){
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      var response = await http.post(

        Uri.parse(
          "https://khelbindass99.com/bgf/api/bgf_login.php",
        ),

        body: {

          "username":
          usernameController.text,

          "password":
          passwordController.text,

        },

      );

      var data =
      jsonDecode(response.body);

      if(data["status"]=="success"){

        SharedPreferences prefs =
        await SharedPreferences.getInstance();

        await prefs.setBool(
          "isLoggedIn",
          true,
        );

        await prefs.setString(
          "username",
          data["username"],
        );

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_)=>UserHome(
              data["username"],
            ),

          ),

        );

      }else{

        showMsg(
          data["message"] ??
              "Login Failed",
        );

      }

    } catch(e){

      showMsg(e.toString());

    }

    setState(() {
      loading = false;
    });
  }

  void showMsg(String msg){

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(msg),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xff111111),

      body: Center(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(20),

          child: Column(

            children: [

              const Icon(
                Icons.forum,
                color: Colors.amber,
                size: 100,
              ),

              const SizedBox(height: 20),

              const Text(

                "BINDASS GUESSING FORUM",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight:
                  FontWeight.bold,
                ),

              ),

              const SizedBox(height: 30),

              TextField(

                controller:
                usernameController,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                const InputDecoration(

                  hintText:
                  "Username",

                  hintStyle:
                  TextStyle(
                    color:
                    Colors.white54,
                  ),

                ),

              ),

              const SizedBox(height: 15),

              TextField(

                controller:
                passwordController,

                obscureText: true,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                const InputDecoration(

                  hintText:
                  "Password",

                  hintStyle:
                  TextStyle(
                    color:
                    Colors.white54,
                  ),

                ),

              ),

              const SizedBox(height: 25),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed:
                  loading
                      ? null
                      : login,

                  child: loading

                      ? const CircularProgressIndicator()

                      : const Text(
                    "LOGIN",
                  ),

                ),

              ),

              TextButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_)=>
                      RegisterPage(),

                    ),

                  );

                },

                child: const Text(
                  "Create Account",
                ),

              ),

              TextButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_)=>
                      const ForgotPasswordPage(),

                    ),

                  );

                },

                child: const Text(
                  "Forgot Password",
                ),

              ),

            ],

          ),

        ),

      ),

    );
  }
}
