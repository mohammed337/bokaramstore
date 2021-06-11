class Get_all_products_category_json {
  String message;
  int errNum;
  bool status;
  int total;
  Result result;

  Get_all_products_category_json(
      {this.message, this.errNum, this.status, this.total, this.result});

  Get_all_products_category_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errNum = json['errNum'];
    status = json['status'];
    total = json['total'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['errNum'] = this.errNum;
    data['status'] = this.status;
    data['total'] = this.total;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String categoryImg;
  List<AllProducts> allProducts;

  Result({this.categoryImg, this.allProducts});

  Result.fromJson(Map<String, dynamic> json) {
    categoryImg = json['category_img'];
    if (json['all_products'] != null) {
      allProducts = new List<AllProducts>();
      json['all_products'].forEach((v) {
        allProducts.add(new AllProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_img'] = this.categoryImg;
    if (this.allProducts != null) {
      data['all_products'] = this.allProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllProducts {
  int exitCart;
  int favExit;
  String totalRate;
  String offerName;
  String offerId;
  String currencyName;
  String oldPrice;
  String newPrice;
  String discountPercentage;
  String imageCateg;
  String whatsapp;
  String shareLink;

  AllProducts(
      {this.exitCart,
        this.favExit,
        this.totalRate,
        this.offerName,
        this.offerId,
        this.currencyName,
        this.oldPrice,
        this.newPrice,
        this.discountPercentage,
        this.imageCateg,
        this.whatsapp,
        this.shareLink});

  AllProducts.fromJson(Map<String, dynamic> json) {
    exitCart = json['exit_cart'];
    favExit = json['fav_exit'];
    totalRate = json['total_rate'];
    offerName = json['offer_name'];
    offerId = json['offer_id'];
    currencyName = json['currency_name'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    discountPercentage = json['discount_percentage'];
    imageCateg = json['image_categ'];
    whatsapp = json['whatsapp'];
    shareLink = json['share_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exit_cart'] = this.exitCart;
    data['fav_exit'] = this.favExit;
    data['total_rate'] = this.totalRate;
    data['offer_name'] = this.offerName;
    data['offer_id'] = this.offerId;
    data['currency_name'] = this.currencyName;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['image_categ'] = this.imageCateg;
    data['whatsapp'] = this.whatsapp;
    data['share_link'] = this.shareLink;
    return data;
  }
}
