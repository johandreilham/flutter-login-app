import 'dart:convert';

import 'package:app_login/home_page.dart';
import 'package:app_login/login/login_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  register(BuildContext context) async {
    String url =
        "http://192.168.184.232/api_flutter/user_login/user/register.php";
    var response = await http.post(Uri.parse(url), body: {
      'username': controllerUsername.text,
      'password': controllerPassword.text,
    });
    Map responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      DInfo.snackBarSuccess(context, 'Success Register');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      if (responseBody['message'] == 'username') {
        DInfo.snackBarError(context, 'Username has already exist');
      } else {
        DInfo.snackBarError(context, 'Failed Register');
      }
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
            DView.textTitle("Register Page"),
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
                    onPressed: () => register(context),
                    child: const Text('Register'))),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Login'))),
          ],
        ),
      ),
    );
  }
}
