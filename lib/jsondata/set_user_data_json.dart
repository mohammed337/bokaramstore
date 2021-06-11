class Set_user_data_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Set_user_data_json({this.message, this.errNum, this.status, this.result});

  Set_user_data_json.fromJson(Map<String, dynamic> json) {
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
  List<OrderDetails> orderDetails;

  Result({this.orderDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int codeName;
  int idOrder;
  String totalPrice;
  String totalProduct;
  String phone;
  String fullname;
  String address;
  String antherAddress;
  String date;

  OrderDetails(
      {this.codeName,
        this.idOrder,
        this.totalPrice,
        this.totalProduct,
        this.phone,
        this.fullname,
        this.address,
        this.antherAddress,
        this.date});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    phone = json['phone'];
    fullname = json['fullname'];
    address = json['address'];
    antherAddress = json['anther_address'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['phone'] = this.phone;
    data['fullname'] = this.fullname;
    data['address'] = this.address;
    data['anther_address'] = this.antherAddress;
    data['date'] = this.date;
    return data;
  }
}
