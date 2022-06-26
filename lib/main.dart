import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/home_nav.dart';
import 'package:flutter_wisata/pages/login%20register/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Wisata',
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? MyApp() : LandingPage()
    ),
  );
}
