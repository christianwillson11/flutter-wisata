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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const LandingPage();
    }));
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .get()
        .then((value) {
      currentUserData = UserModel.fromMap(value.data());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Fullname'),
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
                          label: Text('${currentUserData.fullname}')),
                    )),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Email'),
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
                  alignment: Alignment.centerLeft,
                  child: Text('Birthday'),
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
                  alignment: Alignment.centerLeft,
                  child: Text('Phone'),
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
    );
  }
}

class DateFormat {
  DateFormat(String s);
}
