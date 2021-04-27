import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Column(
        children: [
          Spacer(),
          Container(
              height: 50,
              //color: Colors.purple,
              child: Text('something'))
        ],
      ),
    );
  }
}
