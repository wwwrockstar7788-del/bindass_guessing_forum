import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();

  bool otpSent = false;
  bool otpVerified = false;


  bool loading = false;

  Future<void> sendOtp() async {

    var res = await http.post(
      Uri.parse("https://khelbindass99.com/send_otp.php"),
      body: {
        "mobile": mobile.text,
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
      Uri.parse("https://khelbindass99.com/verify_otp.php"),
      body: {
        "mobile": mobile.text,
        "otp": otp.text,
      },
    );

    var data = jsonDecode(res.body);

    if(data["status"] == "success"){

      setState(() {
        otpVerified = true;
      });

      showMsg("OTP Verified");

    }else{

      showMsg("Invalid OTP");
    }
  }

  Future<void> register() async {

    if (username.text.isEmpty ||
        password.text.isEmpty){
      showMsg("Please fill all fields");
      return;
    }


    setState(() => loading = true);

    try {
      var response = await http.post(
        Uri.parse("https://khelbindass99.com/bgf/api/bgf_register.php"),
        body: {
          "username": username.text,
          "password": password.text,

        },
      );

      var data = jsonDecode(response.body);
      showMsg(data["message"] ?? "Registered");
    } catch (e) {
      showMsg(e.toString());
    }

    setState(() => loading = false);
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
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
          children: [
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffffc107).withOpacity(0.10),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -60,
              child: Container(
                height: 260,
                width: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffffc107).withOpacity(0.08),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // LOGO
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffffc107),
                            Color(0xffffb300),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1,
                        size: 55,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // CARD
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "CREATE ACCOUNT",
                            style: TextStyle(
                              color: Color(0xffffc107),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),

                          const SizedBox(height: 20),

                          buildField("Username", Icons.person, username),
                          buildField("Mobile Number", Icons.phone, mobile,
                              keyboard: TextInputType.number),
                          buildField("Password", Icons.lock, password,
                              obscure: true),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: sendOtp,
                              child: const Text("SEND OTP"),
                            ),
                          ),

                          const SizedBox(height: 10),

                          if(otpSent)
                            buildField(
                              "Enter OTP",
                              Icons.sms,
                              otp,
                              keyboard: TextInputType.number,
                            ),

                          if(otpSent)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: verifyOtp,
                                child: Text(
                                  otpVerified
                                      ? "OTP VERIFIED ✅"
                                      : "VERIFY OTP",
                                ),
                              ),
                            ),
                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffffc107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: loading ? null : register,
                              child: loading
                                  ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                                  : const Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                            child: Text("Already Register"),
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

  Widget buildField(
      String hint,
      IconData icon,
      TextEditingController controller, {
        bool obscure = false,
        TextInputType keyboard = TextInputType.text,
        int? max,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        maxLength: max,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: Colors.amber),
          filled: true,
          fillColor: const Color(0xff0F172A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}