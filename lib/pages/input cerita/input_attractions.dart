import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputAttractions extends StatefulWidget {
  const InputAttractions({Key? key}) : super(key: key);

  @override
  State<InputAttractions> createState() => _InputAttractionsState();
}

class _InputAttractionsState extends State<InputAttractions> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Input Kota"),
        ),
        body: Center(
          child: Text("Hello World,,, masih belum..."),
        ),
      ),
    );
  }
}
