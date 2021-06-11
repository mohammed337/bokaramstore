class Get_contact_info_json {
  int errNum;
  bool status;
  Result result;

  Get_contact_info_json({this.errNum, this.status, this.result});

  Get_contact_info_json.fromJson(Map<String, dynamic> json) {
    errNum = json['errNum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errNum'] = this.errNum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<ContactInfo> contactInfo;

  Result({this.contactInfo});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['contact_info'] != null) {
      contactInfo = new List<ContactInfo>();
      json['contact_info'].forEach((v) {
        contactInfo.add(new ContactInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contactInfo != null) {
      data['contact_info'] = this.contactInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactInfo {
  String address;
  String facebook;
  String twitter;
  String linkedin;
  String instagram;
  String phone;
  String email;
  String mobile;
  String hotline;
  String map;

  ContactInfo(
      {this.address,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.instagram,
        this.phone,
        this.email,
        this.mobile,
        this.hotline,
        this.map});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    phone = json['phone'];
    email = json['email'];
    mobile = json['mobile'];
    hotline = json['hotline'];
    map = json['map'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['instagram'] = this.instagram;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['hotline'] = this.hotline;
    data['map'] = this.map;
    return data;
  }
}
