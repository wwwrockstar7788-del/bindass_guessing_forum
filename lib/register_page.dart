import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController =
      TextEditingController();

  final mobileController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;

  Future<void> register() async {

    if(usernameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        passwordController.text.isEmpty){
      return;
    }

    setState(() {
      loading = true;
    });

    try {

      var response = await http.post(

        Uri.parse(
          "https://khelbindass99.com/bgf/api/bgf_register.php",
        ),

        body: {

          "username":
          usernameController.text,

          "mobile":
          mobileController.text,

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
                "Completed",
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

  Widget field(
      TextEditingController c,
      String hint,
      ) {

    return Padding(

      padding:
      const EdgeInsets.only(
        bottom: 15,
      ),

      child: TextField(

        controller: c,

        style: const TextStyle(
          color: Colors.white,
        ),

        decoration:
        InputDecoration(

          hintText: hint,

          hintStyle:
          const TextStyle(
            color:
            Colors.white54,
          ),

          border:
          const OutlineInputBorder(),

        ),

      ),

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xff111111),

      appBar: AppBar(
        title: const Text(
          "Register",
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            field(
              usernameController,
              "Username",
            ),

            field(
              mobileController,
              "Mobile",
            ),

            field(
              passwordController,
              "Password",
            ),

            const SizedBox(height: 20),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                loading
                    ? null
                    : register,

                child: loading

                    ? const CircularProgressIndicator()

                    : const Text(
                  "REGISTER",
                ),

              ),

            ),

          ],

        ),

      ),

    );
  }
}
