import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'admin_page.dart';
import 'login_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {

  TextEditingController usernameController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  bool loading = false;
  // final AppLinks appLinks = AppLinks();

  Future<void> login() async {
    print("ADMIN LOGIN CLICKED");
    print("USERNAME = ${usernameController.text}");
    print("PASSWORD = ${passwordController.text}");

    if(usernameController.text.isEmpty ||
        passwordController.text.isEmpty){
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      var res = await http.post(

        Uri.parse(
          "https://khelbindass99.com/admin_login.php",
        ),

        body: {

          "username":
          usernameController.text,

          "password":
          passwordController.text,

        },

      );
      print("RESPONSE = ${res.body}");
      var data = jsonDecode(res.body);
      if(data["status"]=="success"){

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder:(_)=>AdminPage(),

          ),

        );

      }else{

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(

            content: Text(
              data["message"],
            ),

          ),

        );

      }

    } catch(e){

      print(e);

    }

    setState(() {
      loading = false;
    });
  }

  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _handleDeepLink();
  // }
  //
  // Future<void> _handleDeepLink() async {
  //
  //   final uri = await appLinks.getInitialLink();
  //
  //   if (uri != null &&
  //       uri.toString() == "khelbindass99://admin") {
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => const AdminLoginPage(),
  //       ),
  //     );
  //   }
  //
  //   appLinks.uriLinkStream.listen((uri) {
  //
  //     if (uri.toString() == "khelbindass99://admin") {
  //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => const AdminLoginPage(),
  //         ),
  //       );
  //     }
  //   });
  // }

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

          children: [

            // TOP CIRCLE

            Positioned(

              top: -100,
              right: -80,

              child: Container(

                height: 250,
                width: 250,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: const Color(0xffffc107)
                      .withOpacity(.10),

                ),

              ),

            ),

            // BOTTOM CIRCLE

            Positioned(

              bottom: -120,
              left: -70,

              child: Container(

                height: 280,
                width: 280,

                decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  color: const Color(0xffffc107)
                      .withOpacity(.08),

                ),

              ),

            ),

            Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(24),

                child: Column(

                  children: [

                    // ADMIN LOGO

                    Container(

                      height: 120,
                      width: 120,

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
                                .withOpacity(.4),

                            blurRadius: 25,

                          ),

                        ],

                      ),

                      child: const Icon(

                        Icons.admin_panel_settings,

                        size: 60,

                        color: Colors.black,

                      ),

                    ),

                    const SizedBox(height: 30),

                    // LOGIN CARD

                    Container(

                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(

                        color:
                        Colors.black.withOpacity(.45),

                        borderRadius:
                        BorderRadius.circular(24),

                        border: Border.all(

                          color: Colors.amber
                              .withOpacity(.25),

                        ),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black
                                .withOpacity(.35),

                            blurRadius: 20,

                          ),

                        ],

                      ),

                      child: Column(

                        children: [

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

                              "ADMIN LOGIN",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 28,

                                fontWeight:
                                FontWeight.bold,

                                letterSpacing: 2,

                              ),

                            ),

                          ),

                          const SizedBox(height: 30),

                          // USERNAME

                          buildField(

                            controller:
                            usernameController,

                            hint: "Admin Username",

                            icon: Icons.person,

                          ),

                          const SizedBox(height: 18),

                          // PASSWORD

                          buildField(

                            controller:
                            passwordController,

                            hint: "Admin Password",

                            icon: Icons.lock,

                            obscure: true,

                          ),

                          const SizedBox(height: 25),

                          // LOGIN BUTTON

                          SizedBox(

                            width: double.infinity,

                            height: 58,

                            child: ElevatedButton(

                              style:
                              ElevatedButton.styleFrom(

                                backgroundColor:
                                const Color(
                                    0xffffc107),

                                foregroundColor:
                                Colors.black,

                                elevation: 10,

                                shadowColor:
                                Colors.amber,

                                shape:
                                RoundedRectangleBorder(

                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      18),

                                ),

                              ),

                              onPressed:
                              loading ? null : login,

                              child: loading

                                  ? const CircularProgressIndicator(
                                color:
                                Colors.black,
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
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>LoginPage()),
                              );
                            },
                            child: Text("User Login",
                                style: TextStyle(
                              color: Colors.amber,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            )),
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
  Widget buildField({

    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool obscure = false,

  }) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.white54,
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.amber,
        ),

        filled: true,

        fillColor: const Color(
          0xff0F172A,
        ),

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(14),

          borderSide: BorderSide.none,

        ),

      ),

    );

  }
}