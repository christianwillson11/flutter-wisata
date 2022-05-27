import 'package:flutter/material.dart';
import 'package:flutter_wisata/home_nav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  void moveToMainApp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const MyApp();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Text("Hello World"),
            ElevatedButton(
              onPressed: () {
                moveToMainApp();
              },
              child: Text("Press Me"),
            ),
          ],
        )),
      ),
    );
  }
}
