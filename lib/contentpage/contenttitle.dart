import 'package:flutter/material.dart';

class ContentTitle extends StatelessWidget {
  final myTextTheme = TextStyle(fontSize: 18, fontFamily: 'DoHyeonRegular');
  final myTextThemeU = TextStyle(
      fontSize: 18, fontFamily: 'DoHyeonRegular', color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Center(
              child: Container(
                  child: Text(
            '임금항목',
            style: myTextTheme,
          ))),
        ),
        Expanded(
          flex: 2,
          child: Center(
              child: Container(
                  child: Text(
            '지급금액',
            style: myTextTheme,
          ))),
        ),
      ],
    );
  }
}
