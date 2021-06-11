class Update_order_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Update_order_json({this.message, this.errNum, this.status, this.result});

  Update_order_json.fromJson(Map<String, dynamic> json) {
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
  int orderId;
  int codeName;
  String totalPrice;
  int totalProduct;
  String date;

  OrderDetails(
      {this.orderId,
        this.codeName,
        this.totalPrice,
        this.totalProduct,
        this.date});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    codeName = json['code_name'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['code_name'] = this.codeName;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['date'] = this.date;
    return data;
  }
}
