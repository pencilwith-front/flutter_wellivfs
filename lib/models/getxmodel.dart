import 'package:flutter_wellivfs/models/login.dart';
import 'package:flutter_wellivfs/models/paymentmodel.dart';
import 'package:get/get.dart';

class GetCustomCtl extends GetxController {
  LoginInfo employee;
  Future<PaymentModel> futurePM;
  var bankSum = 0.obs;

  insertLoginInfo(LoginInfo li) {
    this.employee = li;
    update();
  }

  insertPaymentModel(Future<PaymentModel> oo) {
    this.futurePM = oo;
    oo.then((value) {
      if (value == null) {
        this.bankSum(0);
      } else {
        this.bankSum(value.bANKSUM);
      }
    });
    update();
  }
}
