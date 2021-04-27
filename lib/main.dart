import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wellivfs/models/getxmodel.dart';
import 'package:flutter_wellivfs/models/login.dart';
import 'package:flutter_wellivfs/paymentpage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'expackages/rlb.dart';

// BannerAd ba = BannerAd(
//     adUnitId: BannerAd.testAdUnitId,
//     size: AdSize.banner,
//     listener: (MobileAdEvent event) {
//       print('$event');
//     });

void main() {
  runApp(GetMaterialApp(
    // localizationsDelegates: [
    //   GlobalMaterialLocalizations.delegate,
    //   GlobalWidgetsLocalizations.delegate,
    // ],
    // supportedLocales: [Locale('ko')],
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blueGrey),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final FocusNode _idFocusNode = new FocusNode();
  final FocusNode _pwdFocusNode = new FocusNode();
  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  final GetCustomCtl _gc = Get.put(GetCustomCtl());
  SharedPreferences _prefs;

  @override
  void initState() {
    // FirebaseAdMob.instance
    //     .initialize(appId: 'ca-app-pub-4628159324998827~9794560312');
    //
    // ba
    //   ..load()
    //   ..show(anchorOffset: 0, anchorType: AnchorType.bottom);

    HttpOverrides.global = new MyHttpOverrides(); //android ssl handshake error
    super.initState();
    _loadLogin();
  }

  _loadLogin() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _idController.text = (_prefs.getString('WId') ?? "");
      _pwdController.text = (_prefs.getString('WPwd') ?? "");
    });
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _pwdFocusNode.dispose();
    _idController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(),
                  Text(
                    'WELLIV',
                    style: TextStyle(
                      color: Colors.black, // fontSize: screenSize.width * 0.03
                    ),
                  ),
                  Text('F&S',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //    fontSize: screenSize.width * 0.039
                      )),
                  Spacer(),
                ],
              ),
            ),
            width: 100,
            height: 100,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    focusNode: _idFocusNode,
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: '사번을 입력하세요',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    focusNode: _pwdFocusNode,
                    controller: _pwdController,
                    decoration: InputDecoration(labelText: '비밀번호를 입력하세요'),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
          RoundedLoadingButton(
            onPressed: _doSomething,
            height: 40,
            color: Color.fromRGBO(77, 77, 76, 100),
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            controller: _btnController,
            width: 150,
          ),
        ],
      ),
    ));
  }

  void _doSomething() async {
    if (_idController.text.length == 0) {
      Get.snackbar('사번 공백', '사번이 입력되지 않았습니다.',
          snackPosition: SnackPosition.TOP);
      _idFocusNode.requestFocus();
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });
    } else if (_pwdController.text.length == 0) {
      Get.snackbar('비밀번호 공백', '비밀번호가 입력되지 않았습니다.',
          snackPosition: SnackPosition.TOP);
      _pwdFocusNode.requestFocus();
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });
    } else {
      int result;
      await _postDatabase(_idController.text, _pwdController.text)
          .then((value) => result = value);
      print(result);
      _btnController.reset();

      if (result == 1) {
        Timer(Duration(milliseconds: 300), () {
          Get.snackbar('사번/비번 오류', '사번 또는 비밀번호가 맞지 않습니다.',
              snackPosition: SnackPosition.TOP);
          _btnController.reset();
          _idFocusNode.requestFocus();
        });
      } else if (result == 9) {
        if (_gc.employee.mainData.first.cOCODE == '0000') {
          //if (_gc.employee.mainData.first.cOCODE == '0000') {
          _prefs.setString('WId', _idController.text);
          _prefs.setString('WPwd', _pwdController.text);
          _btnController.success();
          Timer(Duration(milliseconds: 900), () {});
          Get.off(PaymentPage());
        } else {
          Get.snackbar('권한범위', '웰리브 F&S 임직원만 사용가능합니다.',
              snackPosition: SnackPosition.TOP);
          _btnController.reset();
          _idFocusNode.requestFocus();
        }
      }
    }
  }

  Future<int> _postDatabase(String id, String pwd) async {
    var url =
        'https://m.welliv.co.kr/android_app/fs/flutter_DBConnect_idpwd.jsp';
    var response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: <String, String>{
      'mId': id,
      'mPwd': pwd
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _gc.insertLoginInfo(LoginInfo.fromJson(jsonResponse));
      if (_gc.employee.mainData.length == 0) {
        return 1;
      } else {
        return 9;
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
