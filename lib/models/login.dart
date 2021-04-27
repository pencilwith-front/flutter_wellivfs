import 'package:get/get.dart';

class LoginInfo {
  List<MainData> mainData;

  LoginInfo({this.mainData});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    if (json['MainData'] != null) {
      mainData = new List<MainData>();
      json['MainData'].forEach((v) {
        mainData.add(new MainData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainData != null) {
      data['MainData'] = this.mainData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainData {
  String eMPNAMEKOR;
  String bSNSPLCCODE;
  String pSTNDESC;
  String eMPNO;
  String dEPTDESC;
  String hANDPHONNO;
  String cOCODE;
  String pSTNCODE;
  String iNTNMAILID;

  MainData(
      {this.eMPNAMEKOR,
      this.bSNSPLCCODE,
      this.pSTNDESC,
      this.eMPNO,
      this.dEPTDESC,
      this.hANDPHONNO,
      this.cOCODE,
      this.pSTNCODE,
      this.iNTNMAILID});

  MainData.fromJson(Map<String, dynamic> json) {
    eMPNAMEKOR = json['EMP_NAME_KOR'];
    bSNSPLCCODE = json['BSNS_PLC_CODE'];
    pSTNDESC = json['PSTN_DESC'];
    eMPNO = json['EMP_NO'];
    dEPTDESC = json['DEPT_DESC'];
    hANDPHONNO = json['HAND_PHON_NO'];
    cOCODE = json['CO_CODE'];
    pSTNCODE = json['PSTN_CODE'];
    iNTNMAILID = json['INTN_MAIL_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_NAME_KOR'] = this.eMPNAMEKOR;
    data['BSNS_PLC_CODE'] = this.bSNSPLCCODE;
    data['PSTN_DESC'] = this.pSTNDESC;
    data['EMP_NO'] = this.eMPNO;
    data['DEPT_DESC'] = this.dEPTDESC;
    data['HAND_PHON_NO'] = this.hANDPHONNO;
    data['CO_CODE'] = this.cOCODE;
    data['PSTN_CODE'] = this.pSTNCODE;
    data['INTN_MAIL_ID'] = this.iNTNMAILID;
    return data;
  }
}
