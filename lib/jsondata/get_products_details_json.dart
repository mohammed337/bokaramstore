class Get_products_details_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_products_details_json(
      {this.message, this.errNum, this.status, this.result});

  Get_products_details_json.fromJson(Map<String, dynamic> json) {
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
  List<AllSlider> allSlider;
  List<ProductsDetails> productsDetails;

  Result({this.allSlider, this.productsDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_slider'] != null) {
      allSlider = new List<AllSlider>();
      json['all_slider'].forEach((v) {
        allSlider.add(new AllSlider.fromJson(v));
      });
    }
    if (json['products_details'] != null) {
      productsDetails = new List<ProductsDetails>();
      json['products_details'].forEach((v) {
        productsDetails.add(new ProductsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allSlider != null) {
      data['all_slider'] = this.allSlider.map((v) => v.toJson()).toList();
    }
    if (this.productsDetails != null) {
      data['products_details'] =
          this.productsDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllSlider {
  String image;

  AllSlider({this.image});

  AllSlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class ProductsDetails {
  int exitCart;
  int favExit;
  int displayType;
  String videoLink;
  int id;
  String productDetails;
  String currencyName;
  String totalRate;
  String oldPrice;
  String newPrice;
  String discountPercentage;
  String share;
  String whatsapp;

  ProductsDetails(
      {this.exitCart,
        this.favExit,
        this.displayType,
        this.videoLink,
        this.id,
        this.productDetails,
        this.currencyName,
        this.totalRate,
        this.oldPrice,
        this.newPrice,
        this.discountPercentage,
        this.share,
        this.whatsapp});

  ProductsDetails.fromJson(Map<String, dynamic> json) {
    exitCart = json['exit_cart'];
    favExit = json['fav_exit'];
    displayType = json['display_type'];
    videoLink = json['video_link'];
    id = json['id'];
    productDetails = json['product_details'];
    currencyName = json['currency_name'];
    totalRate = json['total_rate'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    discountPercentage = json['discount_percentage'];
    share = json['share'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exit_cart'] = this.exitCart;
    data['fav_exit'] = this.favExit;
    data['display_type'] = this.displayType;
    data['video_link'] = this.videoLink;
    data['id'] = this.id;
    data['product_details'] = this.productDetails;
    data['currency_name'] = this.currencyName;
    data['total_rate'] = this.totalRate;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['share'] = this.share;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
