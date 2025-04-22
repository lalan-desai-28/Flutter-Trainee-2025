class ProfileSuccess {
  String? message;
  Data? data;

  ProfileSuccess({this.message, this.data});

  ProfileSuccess.fromJson(Map<String, dynamic> json) {
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
  String? sFullName;
  String? sEmail;
  String? eLoginMethod;
  int? nPhoneNumber;
  String? sProfileImage;

  Data(
      {this.sId,
        this.sFullName,
        this.sEmail,
        this.eLoginMethod,
        this.nPhoneNumber,
        this.sProfileImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sFullName = json['sFullName'];
    sEmail = json['sEmail'];
    eLoginMethod = json['eLoginMethod'];
    nPhoneNumber = json['nPhoneNumber'];
    sProfileImage = json['sProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sFullName'] = this.sFullName;
    data['sEmail'] = this.sEmail;
    data['eLoginMethod'] = this.eLoginMethod;
    data['nPhoneNumber'] = this.nPhoneNumber;
    data['sProfileImage'] = this.sProfileImage;
    return data;
  }
}