import 'dart:convert';

import 'package:app_login/home_page.dart';
import 'package:app_login/login/register_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) async {
    String url = "http://192.168.184.232/api_flutter/user_login/user/login.php";
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.snackBarSuccess(context, 'Success Login');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      DInfo.snackBarError(context, 'Failed Login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DView.textTitle("Login Page"),
            DView.spaceHeight(),
            DInput(
              controller: controllerUsername,
              hint: "Username",
            ),
            DView.spaceHeight(),
            DInput(
              controller: controllerPassword,
              hint: "Password",
            ),
            DView.spaceHeight(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => login(context),
                    child: const Text('Login'))),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: const Text('Register'))),
          ],
        ),
      ),
    );
  }
}
