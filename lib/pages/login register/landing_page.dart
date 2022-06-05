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

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                child: Image.asset('lib/images/tourist.png'),
              ),
              const Text("Welcome!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(height: 10,),
              const Text("Travel with LOVE in Our App",
                style: TextStyle(
                  fontSize: 20
                ),),
              SizedBox(height: 10,),
              SizedBox(
                width: 350,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  color: Colors.purple,
                  onPressed: (){
                    moveToRegister();
                  }, 
                  child: const Text('SIGN UP',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  
                )
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 350,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  color: Colors.purple,
                  onPressed: (){
                    moveToLogin();
                  }, 
                  child: const Text('SIGN IN',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  
                )
              ),
              SizedBox(height: 20,),
              
            ],
          ),
        )
      ),
      
    );
  }
}