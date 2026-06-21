import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {

  TextEditingController mobileController =
  TextEditingController();

  TextEditingController otpController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  bool otpSent = false;
  bool otpVerified = false;

  Future<void> sendOtp() async {

    var res = await http.post(

      Uri.parse(
        "https://khelbindass99.com/send_otp.php",
      ),

      body: {
        "mobile": mobileController.text,
      },

    );

    var data = jsonDecode(res.body);

    if(data["success"] == true){

      setState(() {
        otpSent = true;
      });

      showMsg("OTP Sent");

    }else{

      showMsg(data["message"]);

    }

  }

  Future<void> verifyOtp() async {

    var res = await http.post(

      Uri.parse(
        "https://khelbindass99.com/verify_otp.php",
      ),

      body: {

        "mobile":
        mobileController.text,

        "otp":
        otpController.text,

      },

    );

    var data = jsonDecode(res.body);

    if(data["status"]=="success"){

      setState(() {
        otpVerified = true;
      });

      showMsg("OTP Verified");

    }else{

      showMsg("Invalid OTP");

    }

  }

  Future<void> updatePassword() async {

    if(!otpVerified){

      showMsg("Verify OTP First");

      return;
    }

    var res = await http.post(

      Uri.parse(
        "https://khelbindass99.com/forgot_password.php",
      ),

      body: {

        "mobile":
        mobileController.text,

        "password":
        passwordController.text,

      },

    );

    var data = jsonDecode(res.body);

    showMsg(data["message"]);

    if(data["status"]=="success"){

      Navigator.pop(context);

    }

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff000000),
        centerTitle: true,
        title: Text("Forgot Password",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffffc107),
            letterSpacing: 1,

          ),
        ),
      ),

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
                  ).withOpacity(.12),

                ),

              ),

            ),

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
                  ).withOpacity(.08),

                ),

              ),

            ),

            SafeArea(

              child: Center(

                child: SingleChildScrollView(

                  padding: const EdgeInsets.all(24),

                  child: Column(

                    children: [

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

                              color: Colors.amber.withOpacity(.4),

                              blurRadius: 25,

                              spreadRadius: 2,

                            ),

                          ],

                        ),

                        child: const Icon(

                          Icons.lock_reset,

                          size: 60,

                          color: Colors.black,

                        ),

                      ),

                      const SizedBox(height: 30),

                      Container(

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(

                          color: Colors.black.withOpacity(.45),

                          borderRadius:
                          BorderRadius.circular(24),

                          border: Border.all(

                            color: Colors.amber
                                .withOpacity(.25),

                          ),

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

                                "FORGOT PASSWORD",

                                style: TextStyle(

                                  color: Colors.white,

                                  fontSize: 28,

                                  fontWeight:
                                  FontWeight.bold,

                                  letterSpacing: 2,

                                ),

                              ),

                            ),

                            const SizedBox(height: 10),

                            const Text(

                              "Reset your account password securely",

                              textAlign: TextAlign.center,

                              style: TextStyle(

                                color: Colors.white70,

                              ),

                            ),

                            const SizedBox(height: 25),

                            buildField(

                              controller:
                              mobileController,

                              hint: "Mobile Number",

                              icon: Icons.phone,

                              keyboard:
                              TextInputType.phone,

                            ),

                            const SizedBox(height: 20),

                            SizedBox(

                              width: double.infinity,
                              height: 55,

                              child: ElevatedButton(

                                style:
                                ElevatedButton.styleFrom(

                                  backgroundColor:
                                  const Color(
                                    0xffffc107,
                                  ),

                                  foregroundColor:
                                  Colors.black,

                                  shape:
                                  RoundedRectangleBorder(

                                    borderRadius:
                                    BorderRadius.circular(
                                      16,
                                    ),

                                  ),

                                ),

                                onPressed: sendOtp,

                                child: const Text(

                                  "SEND OTP",

                                  style: TextStyle(

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 16,

                                  ),

                                ),

                              ),

                            ),

                            if (otpSent) ...[

                              const SizedBox(height: 20),

                              buildField(

                                controller:
                                otpController,

                                hint: "Enter OTP",

                                icon: Icons.sms,

                                keyboard:
                                TextInputType.number,

                              ),

                              const SizedBox(height: 15),

                              SizedBox(

                                width: double.infinity,
                                height: 55,

                                child: ElevatedButton(

                                  style:
                                  ElevatedButton.styleFrom(

                                    backgroundColor:

                                    otpVerified

                                        ? Colors.green

                                        : const Color(
                                      0xff1b5e20,
                                    ),

                                    shape:
                                    RoundedRectangleBorder(

                                      borderRadius:
                                      BorderRadius.circular(
                                        16,
                                      ),

                                    ),

                                  ),

                                  onPressed:
                                  verifyOtp,

                                  child: Text(

                                    otpVerified

                                        ? "OTP VERIFIED ✓"

                                        : "VERIFY OTP",

                                    style:
                                    const TextStyle(

                                      color:
                                      Colors.white,

                                      fontWeight:
                                      FontWeight.bold,

                                    ),

                                  ),

                                ),

                              ),

                            ],

                            if (otpVerified) ...[

                              const SizedBox(height: 20),

                              buildField(

                                controller:
                                passwordController,

                                hint:
                                "New Password",

                                icon: Icons.lock,

                                obscure: true,

                              ),

                              const SizedBox(height: 20),

                              SizedBox(

                                width: double.infinity,
                                height: 55,

                                child: ElevatedButton(

                                  style:
                                  ElevatedButton.styleFrom(

                                    backgroundColor:
                                    Colors.green,

                                    shape:
                                    RoundedRectangleBorder(

                                      borderRadius:
                                      BorderRadius.circular(
                                        16,
                                      ),

                                    ),

                                  ),

                                  onPressed:
                                  updatePassword,

                                  child: const Text(

                                    "UPDATE PASSWORD",

                                    style: TextStyle(

                                      color:
                                      Colors.white,

                                      fontWeight:
                                      FontWeight.bold,

                                      fontSize: 16,

                                    ),

                                  ),

                                ),

                              ),
                            ],

                          ],

                        ),

                      ),

                    ],

                  ),

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

    TextInputType keyboard =
        TextInputType.text,

  }) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      keyboardType: keyboard,

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

        fillColor:
        Colors.white.withOpacity(.08),

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(16),

          borderSide: BorderSide.none,

        ),

      ),

    );

  }
}