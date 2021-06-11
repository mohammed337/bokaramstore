class Empty_cart_json {
  String message;
  int errNum;
  bool status;

  Empty_cart_json({this.message, this.errNum, this.status});

  Empty_cart_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errNum = json['errNum'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errNum'] = this.errNum;
    data['status'] = this.status;
    return data;
  }
}
