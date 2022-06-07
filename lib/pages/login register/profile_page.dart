import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/login%20register/landing_page.dart';

class profilePage extends StatefulWidget {
  const profilePage({ Key? key }) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  void moveToLandingPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LandingPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(       
        child: Center(         
          child :Column(            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                    width: 350,
                    height: 50,                    
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      color: Colors.purple,
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut().then((value) {
                          moveToLandingPage();
                        });
                      }, 
                      child: const Text('SIGN OUT',
                      style: TextStyle(
                        color: Colors.white
                      ),),
                      
                    )
                  ),
            ],
          ),
        ),
      ) ,
    );
  }
}