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

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> resetPassword() async {

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
          "https://khelbindass99.com/bgf/api/bgf_forgot_password.php",
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

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            data["message"] ??
                "Done",
          ),
        ),

      );

      if(data["status"]=="success"){
        Navigator.pop(context);
      }

    } catch(e){

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),

      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xff111111),

      appBar: AppBar(
        title: const Text(
          "Forgot Password",
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller:
              usernameController,

              style:
              const TextStyle(
                color:
                Colors.white,
              ),

              decoration:
              const InputDecoration(
                hintText:
                "Username",
              ),

            ),

            const SizedBox(
              height: 15,
            ),

            TextField(

              controller:
              passwordController,

              style:
              const TextStyle(
                color:
                Colors.white,
              ),

              decoration:
              const InputDecoration(
                hintText:
                "New Password",
              ),

            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                loading
                    ? null
                    : resetPassword,

                child: loading

                    ? const CircularProgressIndicator()

                    : const Text(
                  "RESET PASSWORD",
                ),

              ),

            )

          ],

        ),

      ),

    );
  }
}
