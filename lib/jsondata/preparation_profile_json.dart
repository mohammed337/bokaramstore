class Preparation_profile_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Preparation_profile_json(
      {this.message, this.errNum, this.status, this.result});

  Preparation_profile_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errNum = json['errNum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errNum'] = this.errNum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  CustomerInfo customerInfo;

  Result({this.customerInfo});

  Result.fromJson(Map<String, dynamic> json) {
    customerInfo = json['customer_info'] != null
        ? new CustomerInfo.fromJson(json['customer_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerInfo != null) {
      data['customer_info'] = this.customerInfo.toJson();
    }
    return data;
  }
}

class CustomerInfo {
  int id;
  String name;
  String phone;
  String email;
  String cityId;
  String address;
  String sex;
  String token;

  CustomerInfo(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.cityId,
        this.address,
        this.sex,
        this.token});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    cityId = json['city_id'];
    address = json['address'];
    sex = json['sex'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['sex'] = this.sex;
    data['token'] = this.token;
    return data;
  }
}
