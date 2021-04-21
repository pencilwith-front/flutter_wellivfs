import 'package:flutter/material.dart';

class PeePage extends StatelessWidget {
  List<Map<String, String>> _paymentList = [
    {'본봉': '1000000'},
    {'시간외': '10000'},
    {'가족수당': '5000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return Container(
            child: Text(_paymentList[index].keys.join('').toString()));
        // return Container(
        //     child:
        //         Text(_paymentList.elementAt(index).keys.join("").toString()));
      },
      itemCount: _paymentList.length,
    ));
  }
}
