import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/login%20register/login.dart';
import 'package:flutter_wisata/pages/login%20register/register.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void moveToRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Register();
    }));
  }

  void moveToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing Page"),
      ),

      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                moveToLogin();
              },
              child: Text("Login"),
            ),

            ElevatedButton(
              onPressed: () {
                moveToRegister();
              },
              child: Text("Register"),
            ),
            
          ],
        ),
      ),
      
    );
  }
}