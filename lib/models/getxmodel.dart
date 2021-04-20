import 'package:flutter_wellivfs/models/login.dart';
import 'package:get/get.dart';

class GetCustomCtl extends GetxController {
  LoginInfo employee;

  insertLoginInfo(LoginInfo li) {
    this.employee = li;
    update();
  }
}
