class PaymentModel {
  List<DLIST> dLIST;
  List<PLIST> pLIST;

  PaymentModel({this.dLIST, this.pLIST});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['DLIST'] != null) {
      dLIST = new List<DLIST>();
      json['DLIST'].forEach((v) {
        dLIST.add(new DLIST.fromJson(v));
      });
    }
    if (json['PLIST'] != null) {
      pLIST = new List<PLIST>();
      json['PLIST'].forEach((v) {
        pLIST.add(new PLIST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dLIST != null) {
      data['DLIST'] = this.dLIST.map((v) => v.toJson()).toList();
    }
    if (this.pLIST != null) {
      data['PLIST'] = this.pLIST.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DLIST {
  String wAGEID;
  String wAGEITEMCODE;
  String cODE;
  String sLRYPAYYYMM;
  String cALCAMT;

  DLIST(
      {this.wAGEID,
      this.wAGEITEMCODE,
      this.cODE,
      this.sLRYPAYYYMM,
      this.cALCAMT});

  DLIST.fromJson(Map<String, dynamic> json) {
    wAGEID = json['WAGE_ID'];
    wAGEITEMCODE = json['WAGE_ITEM_CODE'];
    cODE = json['CODE'];
    sLRYPAYYYMM = json['SLRY_PAY_YYMM'];
    cALCAMT = json['CALC_AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WAGE_ID'] = this.wAGEID;
    data['WAGE_ITEM_CODE'] = this.wAGEITEMCODE;
    data['CODE'] = this.cODE;
    data['SLRY_PAY_YYMM'] = this.sLRYPAYYYMM;
    data['CALC_AMT'] = this.cALCAMT;
    return data;
  }
}

class PLIST {
  String wAGEID;
  String wAGEITEMCODE;
  String cODE;
  String sLRYPAYYYMM;
  String cALCAMT;

  PLIST(
      {this.wAGEID,
      this.wAGEITEMCODE,
      this.cODE,
      this.sLRYPAYYYMM,
      this.cALCAMT});

  PLIST.fromJson(Map<String, dynamic> json) {
    wAGEID = json['WAGE_ID'];
    wAGEITEMCODE = json['WAGE_ITEM_CODE'];
    cODE = json['CODE'];
    sLRYPAYYYMM = json['SLRY_PAY_YYMM'];
    cALCAMT = json['CALC_AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WAGE_ID'] = this.wAGEID;
    data['WAGE_ITEM_CODE'] = this.wAGEITEMCODE;
    data['CODE'] = this.cODE;
    data['SLRY_PAY_YYMM'] = this.sLRYPAYYYMM;
    data['CALC_AMT'] = this.cALCAMT;
    return data;
  }
}
