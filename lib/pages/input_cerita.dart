import 'package:flutter/material.dart';

class InputCerita extends StatefulWidget {
  const InputCerita({Key? key}) : super(key: key);

  @override
  State<InputCerita> createState() => _InputCeritaState();
}

class _InputCeritaState extends State<InputCerita> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello World", textScaleFactor: 10.0),
          ElevatedButton(
            child: Text('Hello World'),
            onPressed: () {
              // final CurvedNavigationBarState? navBarState =
              //     _bottomNavigationKey.currentState;
              // navBarState?.setPage(1);
            },
          ),
        ],
      ),
    );
  }
}
