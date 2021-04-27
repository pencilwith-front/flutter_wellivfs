import 'package:flutter/material.dart';
import 'package:flutter_wellivfs/contentpage/contentsum.dart';
import 'package:flutter_wellivfs/contentpage/contenttitle.dart';
import 'package:flutter_wellivfs/models/getxmodel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContentPage extends StatefulWidget {
  final kind;

  ContentPage(this.kind);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final formatCurrency = new NumberFormat.simpleCurrency(
      locale: "ko_KR", name: '', decimalDigits: 0);

  final myTextTheme = TextStyle(fontSize: 18, fontFamily: 'DoHyeonRegular');

  @override
  Widget build(BuildContext context) {
    GetCustomCtl _gc = Get.find();
    return GetBuilder<GetCustomCtl>(builder: (_) {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return Container(
                        color: Colors.grey[300],
                        height: 40,
                        child: ContentTitle());
                  } else if (index ==
                      (widget.kind == 'D'
                          ? snapshot.data.dLIST.length + 1
                          : snapshot.data.pLIST.length + 1)) {
                    return Container(
                        color: Colors.black,
                        height: 40,
                        child: ContentSum(widget.kind == 'D'
                            ? snapshot.data.dSUM
                            : snapshot.data.pSUM));
                  } else {
                    return Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                    '${this.widget.kind == 'D' ? snapshot.data.dLIST[index - 1].cODE : snapshot.data.pLIST[index - 1].cODE}',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: myTextTheme)),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                  '${this.widget.kind == 'D' ? formatCurrency.format(int.parse(snapshot.data.dLIST[index - 1].cALCAMT)) : formatCurrency.format(int.parse(snapshot.data.pLIST[index - 1].cALCAMT))}',
                                  textAlign: TextAlign.end,
                                  style: myTextTheme),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemCount: widget.kind == 'D'
                    ? (snapshot.data.dLIST == null
                        ? 1
                        : snapshot.data.dLIST.length + 2)
                    : (snapshot.data.pLIST == null
                        ? 1
                        : snapshot.data.pLIST.length + 2));
          } else {
            return Center(child: Text('데이터가 없습니다.'));
          }
        },
        future: _gc.futurePM,
      );
    });
  }
}
