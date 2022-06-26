// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/home_nav.dart';
import 'package:flutter_wisata/pages/login%20register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  void moveToRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Register();
    }));
  }

  void passwordChecker() {
    if (_passwordLoginController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must contain at least 6 character");
    } else {

    }
  }

  void moveToMainApp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MyApp();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SIGN IN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Sign in to your account",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: TextField(
                    controller: _emailLoginController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: TextField(
                    controller: _passwordLoginController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 350,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.purple,
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailLoginController.text,
                            password: _passwordLoginController.text
                        );
                        moveToMainApp();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "user-not-found") {
                        Fluttertoast.showToast(
                          msg: "No user found for that email", toastLength: Toast.LENGTH_LONG);
                      } else if (e.code == "wrong-password") {
                        Fluttertoast.showToast(
                          msg: "Wrong password provided for that user.", toastLength: Toast.LENGTH_LONG);
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: e.toString());
                    }
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account ? ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RichText(
                  text: TextSpan(
                      text: "Sign Up",
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          moveToRegister();
                        }),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
