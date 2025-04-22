class SignupSuccess {
  String? message;
  Data? data;

  SignupSuccess({this.message, this.data});

  SignupSuccess.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? sToken;
  String? sFullName;
  String? sEmail;
  String? eLoginMethod;

  Data({this.sId, this.sToken, this.sFullName, this.sEmail, this.eLoginMethod});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sToken = json['sToken'];
    sFullName = json['sFullName'];
    sEmail = json['sEmail'];
    eLoginMethod = json['eLoginMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sToken'] = this.sToken;
    data['sFullName'] = this.sFullName;
    data['sEmail'] = this.sEmail;
    data['eLoginMethod'] = this.eLoginMethod;
    return data;
  }
}