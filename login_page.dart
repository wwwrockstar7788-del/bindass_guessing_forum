import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:bindass_guessing_forum/register_page.dart';
import 'package:bindass_guessing_forum/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ================= CONTROLLERS =================

  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  // ================= LOGIN =================
  Future<void> login() async {

  if (mobileController.text.isEmpty ||
      passwordController.text.isEmpty) {
    showMsg("Please fill all fields");
    return;
  }

    try {
      setState(() {
        loading = true;
      });

      var res = await http.post(
        Uri.parse("https://khelbindass99.com/bgf/api/bgf_login.php"),

        body: {
          "username": mobileController.text,
          "password": passwordController.text,
        },
      );


      print("STATUS = ${res.statusCode}");
      print("BODY = ${res.body}");

      var data = jsonDecode(res.body);

      if (data['status'] == 'success') {
        String username = data['username'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("username", username);

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (_) => UserHome(username)),
        );
      } else {
        showMsg(data['message'] ?? "Login Failed");
      }
    } catch (e) {
      showMsg(e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  // ================= SNACKBAR =================

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    bool isAdmin = false;

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [Color(0xff000000), Color(0xff0d2b14), Color(0xff1b5e20)],
          ),
        ),

        child: Stack(
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

                  color: const Color(0xffffc107).withOpacity(0.12),
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

                  color: const Color(0xffffd54f).withOpacity(0.08),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),

                child: Column(
                  children: [
                    // ================= LOGO =================
                    Container(
                      height: 130,
                      width: 130,

                      padding: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        gradient: const LinearGradient(
                          colors: [Color(0xffffd54f), Color(0xffffb300)],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(.4),

                            blurRadius: 25,

                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: const Color(0xffffd54f),

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

                    // ================= LOGIN CARD =================
                    Container(
                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.45),

                        borderRadius: BorderRadius.circular(24),

                        border: Border.all(
                          color: Colors.amber.withOpacity(.25),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),

                            blurRadius: 20,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [Color(0xfffff8dc), Color(0xffffc107)],
                              ).createShader(bounds);
                            },

                            child: Text(
                              "BINDASS GUESSING FORUM",

                              style: const TextStyle(
                                color: Colors.white,

                                fontSize: 30,

                                fontWeight: FontWeight.bold,

                                letterSpacing: 2,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ================= MOBILE =================
                          TextField(
                            controller: mobileController,

                            onChanged: (v) {
                              setState(() {});
                            },

                            style: const TextStyle(color: Colors.white),

                            decoration: InputDecoration(
                              hintText: "Username",

                              hintStyle: const TextStyle(color: Colors.white70),

                              prefixIcon: Icon(
                                Icons.person,

                                color: Colors.amber,
                              ),

                              filled: true,

                              fillColor: Colors.white.withOpacity(.08),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // ================= PASSWORD =================
                          buildField(
                            controller: passwordController,

                            hint: "Password",

                            icon: Icons.lock,

                            obscure: true,
                          ),

                          const SizedBox(height: 18),

                          if (!isAdmin) const SizedBox(height: 25),

                          // ================= LOGIN BUTTON =================
                          SizedBox(
                            width: double.infinity,

                            height: 58,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffffc107),

                                foregroundColor: Colors.black,

                                elevation: 10,

                                shadowColor: Colors.amber,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: loading ? null : login,

                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : const Text(
                                      "LOGIN",

                                      style: TextStyle(
                                        fontSize: 18,

                                        fontWeight: FontWeight.bold,

                                        letterSpacing: 1,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // ================= REGISTER =================
                          if (!isAdmin)
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterPage(),
                                  ),
                                );
                              },

                              child: const Text(
                                "Create Account",

                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.amber,

                                fontSize: 15,

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMMON TEXTFIELD =================

  Widget buildField({
    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool obscure = false,

    TextInputType keyboard = TextInputType.text,

    int? maxLength,
  }) {
    return TextField(
      controller: controller,

      obscureText: obscure,

      keyboardType: keyboard,

      maxLength: maxLength,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        counterText: "",

        hintText: hint,

        hintStyle: const TextStyle(color: Colors.white54),

        prefixIcon: Icon(icon, color: Colors.white70),

        filled: true,

        fillColor: const Color(0xff0F172A),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
