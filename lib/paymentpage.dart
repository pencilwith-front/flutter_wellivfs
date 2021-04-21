import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wellivfs/models/getxmodel.dart';
import 'package:flutter_wellivfs/models/login.dart';
import 'package:flutter_wellivfs/models/paymentmodel.dart';
import 'package:flutter_wellivfs/peepage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  PaymentModel pm;
  List<Widget> _pageList = [PeePage(), Text('공제사항')];
  final GetCustomCtl _gc = Get.put(GetCustomCtl());

  @override
  void initState() {
    //print(_gc.employee.mainData.first.eMPNAMEKOR);

    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        //TODO
      });
      print("Selected Index: " + _controller.index.toString());
    });

    Future<PaymentModel> futurePM = _makingList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //TODO dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.black54,
        width: double.infinity,
        height: 80,
        child: Text('여기에 합계'),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 50,
              color: Colors.purple,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
            ),
          ),
          Container(
            height: 40,
            child: TabBar(
              indicator: BoxDecoration(
                  color: Colors.blueGrey, border: Border.all(width: 1)),
              controller: _controller,
              tabs: [
                Text(
                  '지급사항',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  '공제사항',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 200,
              color: Colors.white30,
              child: TabBarView(
                controller: _controller,
                children: _pageList,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<PaymentModel> _makingList() async {
    var url = 'https://m.welliv.co.kr/android_app/fs/flutter_fsp.jsp';

    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: <String, String>{
      'pDate': '',
      'pEmployee': '',
      'pCoCode': '',
      'pKind': ''
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      pm = PaymentModel.fromJson(jsonResponse);
      if (pm.pLIST.length == 0) {
        return null;
      } else {
        return pm;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
