class Get_all_myfavorite_json {
  String message;
  int errNum;
  bool status;
  int total;
  Result result;

  Get_all_myfavorite_json(
      {this.message, this.errNum, this.status, this.total, this.result});

  Get_all_myfavorite_json.fromJson(Map<String, dynamic> json) {
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
  List<AllFavourites> allFavourites;

  Result({this.allFavourites});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_favourites'] != null) {
      allFavourites = new List<AllFavourites>();
      json['all_favourites'].forEach((v) {
        allFavourites.add(new AllFavourites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allFavourites != null) {
      data['all_favourites'] =
          this.allFavourites.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllFavourites {
  String offerName;
  String offerId;
  String currencyName;
  String oldPrice;
  String newPrice;
  String discountPercentage;
  String imageCateg;

  AllFavourites(
      {this.offerName,
        this.offerId,
        this.currencyName,
        this.oldPrice,
        this.newPrice,
        this.discountPercentage,
        this.imageCateg});

  AllFavourites.fromJson(Map<String, dynamic> json) {
    offerName = json['offer_name'];
    offerId = json['offer_id'];
    currencyName = json['currency_name'];
    oldPrice = json['old_price'];
    newPrice = json['new_price'];
    discountPercentage = json['discount_percentage'];
    imageCateg = json['image_categ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_name'] = this.offerName;
    data['offer_id'] = this.offerId;
    data['currency_name'] = this.currencyName;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['image_categ'] = this.imageCateg;
    return data;
  }
}
