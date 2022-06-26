import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/home_nav.dart';
import 'package:flutter_wisata/model/UserModel.dart';
import 'package:flutter_wisata/pages/login%20register/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailRegisterController = TextEditingController();
  TextEditingController _passwordRegisterController = TextEditingController();
  TextEditingController _fullnameRegisterController = TextEditingController();
  TextEditingController _phoneNumberRegisterController = TextEditingController();

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

  void sendNewUserData() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userDetail = UserModel();
    userDetail.email = user!.email;
    userDetail.uid = user.uid;
    userDetail.fullname = _fullnameRegisterController.text;
    userDetail.phone = _phoneNumberRegisterController.text;
    userDetail.birthday = "";

    await db
    .collection("users")
    .doc(user.uid)
    .set(userDetail.toMap());

    Fluttertoast.showToast(
                          msg: "Berhasil membuat akun",
                          toastLength: Toast.LENGTH_LONG,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full name',
                        ),
                        controller: _fullnameRegisterController,
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        controller: _emailRegisterController,
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextField(
                        controller: _phoneNumberRegisterController,
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        controller: _passwordRegisterController,
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
                      FirebaseAuth.instance
                        .createUserWithEmailAndPassword(email: _emailRegisterController.text, password: _passwordRegisterController.text)
                        .then((value){
                          
                          moveToMainApp();
                          sendNewUserData();
                        })
                        .catchError((e){
                          Fluttertoast.showToast(msg: e!.message);
                        });
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
          ),
        )
      ),
      
    );
  }
}