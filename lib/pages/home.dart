import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String index;
  const Home({Key? key, required this.index}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.index, textScaleFactor: 10.0),
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
