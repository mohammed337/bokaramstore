class Get_cities_json {
  String message;
  int errNum;
  bool status;
  Result result;

  Get_cities_json({this.message, this.errNum, this.status, this.result});

  Get_cities_json.fromJson(Map<String, dynamic> json) {
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
  List<CityDetailsprofile> cityDetails;

  Result({this.cityDetails});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['city_details'] != null) {
      cityDetails = new List<CityDetailsprofile>();
      json['city_details'].forEach((v) {
        cityDetails.add(new CityDetailsprofile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cityDetails != null) {
      data['city_details'] = this.cityDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityDetailsprofile {
  String cityName;
  int cityId;

  CityDetailsprofile({this.cityName, this.cityId});

  CityDetailsprofile.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    return data;
  }
}
