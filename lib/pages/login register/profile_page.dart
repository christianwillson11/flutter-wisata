// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/UserModel.dart';
import 'package:flutter_wisata/pages/login%20register/landing_page.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  late DateTime _dateTime;
  User? currentUser = FirebaseAuth.instance.currentUser!;
  UserModel currentUserData = UserModel();
  final _fullnameProfile = TextEditingController();
  final _emailProfile = TextEditingController();
  final _birthdayProfile = TextEditingController();
  final _phoneProfile = TextEditingController();

  void moveToLandingPage() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LandingPage()));
  }
  _fetch() async{
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null){
    await FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.uid)
              .get()
              .then((value) {
              currentUserData = UserModel.fromMap(value.data());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.done){
                        return displayUserInfo(context, snapshot);
                      }
                      return CircularProgressIndicator();
                    }),
                  SizedBox(height: 30,),
                  SizedBox(
                      width: 350,
                      height: 50,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.purple,
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            moveToLandingPage();
                          });
                        },
                        child: const Text(
                          'SIGN OUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget displayUserInfo(context, snapshot){
  final user = snapshot.data;
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text('Fullname', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
        ),
      Container(
          child: TextField(
            controller: _fullnameProfile,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
                suffixIcon: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                        .collection("users")
                        .doc(currentUserData.uid);
                    docUser.update({
                      'fullname': _fullnameProfile.text,
                    });
                  },
                ),
                label: Text('${currentUserData.fullname}')
              ),
          )),
      SizedBox(height: 20,),
      Container(
        padding: EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text('Email', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
      ),
      Container(
          child: TextField(
            controller: _emailProfile,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mail),
                label: Text('${currentUserData.email}')),
            enabled: false,
          )),
      SizedBox(height: 20,),
      Container(
        padding: EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text('Birthday', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
      ),
      Container(
          child: TextField(
            controller: _birthdayProfile,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.cake),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2222))
                      .then((res) {
                    setState(() {
                      var date = DateTime.parse(res.toString());
                      var formattedDate =
                          "${date.day}-${date.month}-${date.year}";
                      _birthdayProfile.text = formattedDate;
                      final docUser = FirebaseFirestore.instance
                          .collection("users")
                          .doc(currentUserData.uid);
                      docUser.update({
                        'birthday': _birthdayProfile.text,
                      });
                    });
                  });
                },
              ),
              label: Text('${currentUserData.birthday}'),
            ),
          )),
          SizedBox(height: 20,),
      Container(
        padding: EdgeInsets.only(bottom: 10),
        alignment: Alignment.centerLeft,
        child: Text('Phone', 
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),),
      ),
      Container(
          child: TextField(
            controller: _phoneProfile,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                suffixIcon: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                        .collection("users")
                        .doc(currentUserData.uid);
                    docUser.update({
                      'phone': _phoneProfile.text,
                    });
                  },
                ),
                label: Text('${currentUserData.phone}')),
          )),
    ],
  );
}
}



class DateFormat {
  DateFormat(String s);
}
