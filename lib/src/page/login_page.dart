import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/src/page/category_page.dart';
import 'package:shop/src/page/category_page_2.dart';
import 'package:shop/src/utils/constant.dart';
import 'package:shop/src/utils/route_helper.dart';
import 'package:shop/src/utils/token.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assests/images/logo.png',
            height: 300,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: emailCont,
              decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@gmail.com",
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.access_alarm),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(360)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(360))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: passCont,
              obscureText: !isShowPassword,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "1234",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      icon: Icon(Icons.lock)),
                  prefixIcon: Icon(Icons.password),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(360)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(360))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple)),
                onPressed: () async {
                  final email = emailCont.text;
                  final pass = passCont.text;
                  final res = await http.post(
                      Uri.http(baseUrl, 'api/v1/auth/login'),
                      body: {"email": email, "password": pass});
                  final jsonMap = jsonDecode(res.body) as Map;
                  token = jsonMap['access_token'];
                  pushNewPage(context, CategoryPage2());
                },
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: const Text("Login")))),
          )
        ],
      ),
    );
  }
}
