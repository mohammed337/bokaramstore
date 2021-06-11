class Get_old_orders_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_old_orders_json({this.message, this.errNum, this.status, this.result});

  Get_old_orders_json.fromJson(Map<String, dynamic> json) {
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
  String shippingCharges;
  String currencyName;
  String date;
  String viewStore;
  int viewId;

  OrderDetails(
      {this.codeName,
        this.idOrder,
        this.totalPrice,
        this.totalProduct,
        this.shippingCharges,
        this.currencyName,
        this.date,
        this.viewStore,
        this.viewId});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    shippingCharges = json['shipping_charges'];
    currencyName = json['currency_name'];
    date = json['date'];
    viewStore = json['view_store'];
    viewId = json['view_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['shipping_charges'] = this.shippingCharges;
    data['currency_name'] = this.currencyName;
    data['date'] = this.date;
    data['view_store'] = this.viewStore;
    data['view_id'] = this.viewId;
    return data;
  }
}
