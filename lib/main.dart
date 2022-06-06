import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/login%20register/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    title: 'Flutter Wisata',
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
  ));
}