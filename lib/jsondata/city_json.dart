class City_json {
  String message;
  int errNum;
  bool status;
  Result result;

  City_json({this.message, this.errNum, this.status, this.result});

  City_json.fromJson(Map<String, dynamic> json) {
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
  List<CityDetails> cityDetails;
  List<OrderDetails> orderDetails;

  Result({this.cityDetails, this.orderDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['city_details'] != null) {
      cityDetails = new List<CityDetails>();
      json['city_details'].forEach((v) {
        cityDetails.add(new CityDetails.fromJson(v));
      });
    }
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cityDetails != null) {
      data['city_details'] = this.cityDetails.map((v) => v.toJson()).toList();
    }
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityDetails {
  String cityName;
  int cityId;
  String shippingCharges;

  CityDetails({this.cityName, this.cityId, this.shippingCharges});

  CityDetails.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    cityId = json['city_id'];
    shippingCharges = json['shipping_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    data['shipping_charges'] = this.shippingCharges;
    return data;
  }
}

class OrderDetails {
  int codeName;
  int idOrder;
  String totalPrice;
  String totalProduct;
  String currencyName;

  OrderDetails(
      {this.codeName,
        this.idOrder,
        this.totalPrice,
        this.totalProduct,
        this.currencyName});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    codeName = json['code_name'];
    idOrder = json['id_order'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
    currencyName = json['currency_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_name'] = this.codeName;
    data['id_order'] = this.idOrder;
    data['total_price'] = this.totalPrice;
    data['total_product'] = this.totalProduct;
    data['currency_name'] = this.currencyName;
    return data;
  }
}
