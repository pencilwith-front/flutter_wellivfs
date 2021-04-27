import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContentSum extends StatelessWidget {
  final myTextTheme = TextStyle(
    fontSize: 18,
    fontFamily: 'DoHyeonRegular',
    color: Colors.white,
  );

  final formatCurrency = new NumberFormat.simpleCurrency(
      locale: "ko_KR", name: '', decimalDigits: 0);

  final allSum;

  ContentSum(this.allSum);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('총합계',
                    textAlign: TextAlign.start, style: myTextTheme)),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Text('${formatCurrency.format(allSum)}',
                  textAlign: TextAlign.end, style: myTextTheme),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
