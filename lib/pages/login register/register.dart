import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/home_nav.dart';
import 'package:flutter_wisata/pages/login%20register/login.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  void moveTolOGIN() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const Login();
    }));
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
              const Text("SIGN UP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(height: 10,),
              const Text("Create an account, It's free",
                style: TextStyle(
                  fontSize: 20
                ),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                    
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
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
                    moveToMainApp();
                  }, 
                  child: const Text('SIGN UP',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  
                )
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  RichText(
                    text: TextSpan(
                      text: "Sign In",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = (){
                        moveTolOGIN();
                      }
                    ),
                    
                  )
                  
                  
                ],
              )
            ],
          ),
        )
      ),
      
    );
  }
}