import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_wellivfs/contentpage/contentpage.dart';
import 'package:flutter_wellivfs/models/getxmodel.dart';
import 'package:flutter_wellivfs/models/paymentmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Widget> _pageList = [ContentPage('P'), ContentPage('D')];
  final GetCustomCtl _gc = Get.put(GetCustomCtl());

  final myTextThemeTitle =
      TextStyle(fontSize: 22, fontFamily: 'DoHyeonRegular');
  final myTextTheme = TextStyle(fontSize: 18, fontFamily: 'DoHyeonRegular');
  final myTextThemeU = TextStyle(
      fontSize: 18, fontFamily: 'DoHyeonRegular', color: Colors.black);

  final myDateFormatter = DateFormat('yyyy년 MM월');
  final sendDateFormatter = DateFormat('yyyyMMdd');
  DateTime initialDate = DateTime.now();
  DateTime selectedDate;

  final _paymentList = <String>['급여', '상여', '연차'];
  String _selectedValue = '급여';

  final formatCurrency = new NumberFormat.simpleCurrency(
      locale: "ko_KR", name: '', decimalDigits: 0);

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        //TODO
      });
      print("Selected Index: " + _controller.index.toString());
    });

    selectedDate = DateTime(initialDate.year, initialDate.month - 1);
    _gc.insertPaymentModel(_makingList());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //TODO dismiss keyboard

    dismissKeyboard();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Column(
          children: [
            Spacer(),
            Container(
              height: 50,
              //color: Colors.purple,
              child: GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2021, 3),
                      maxTime: DateTime(2030, 12),
                      theme: DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    setState(() {
                      selectedDate = date;
                      _gc.insertPaymentModel(_makingList());
                    });
                  }, currentTime: selectedDate, locale: LocaleType.ko);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                        value: _selectedValue,
                        items: _paymentList.map((value) {
                          return DropdownMenuItem(
                            child: Text(
                              value,
                              style: myTextThemeTitle,
                            ),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                            _gc.insertPaymentModel(_makingList());
                          });
                        }),
                    Text('${myDateFormatter.format(selectedDate)}',
                        style: myTextTheme),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 180,
                  //height: 30,
                  child: Image.asset(
                    'assets/026565.jpg',
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.grey[850],
//                border: Border.all(width: 0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                controller: _controller,
                tabs: [
                  _controller.index == 0
                      ? Text(
                          '지급사항',
                          style: myTextTheme,
                        )
                      : Text(
                          '지급사항',
                          style: myTextThemeU,
                        ),
                  _controller.index == 1
                      ? Text(
                          '공제사항',
                          style: myTextTheme,
                        )
                      : Text(
                          '공제사항',
                          style: myTextThemeU,
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                //height: 200,
                color: Colors.white30,
                child: TabBarView(
                  controller: _controller,
                  children: _pageList,
                ),
              ),
            ),
            Container(
              child: Center(
                child: Obx(
                  () => Text(
                    '이체금액 : ${formatCurrency.format(_gc.bankSum)}',
                    textScaleFactor: 1.2,
                    style: myTextTheme,
                  ),
                ),
              ),
              //color: Colors.red,
            ),
//            Container(height: 50, color: Colors.black)
          ],
        ),
      ),
    );
  }

  Future<PaymentModel> _makingList() async {
    var kind;
    if (_selectedValue == '급여') {
      kind = 'P';
    } else if (_selectedValue == '상여') {
      kind = 'B';
    } else {
      kind = 'Y';
    }
    var url = 'https://m.welliv.co.kr/android_app/fs/flutter_fsp.jsp';
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: <String, String>{
      'pDate': sendDateFormatter.format(selectedDate).toString(),
      'pEmployee': _gc.employee.mainData[0].eMPNO.toString(),
      'pCoCode': _gc.employee.mainData[0].cOCODE.toString(),
      'pKind': kind
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      PaymentModel pm = PaymentModel.fromJson(jsonResponse);
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

  void dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.didChangeDependencies();
  }
}
