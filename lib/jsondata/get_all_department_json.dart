class Get_all_department_json {
  int errNum;
  bool status;
  Result result;

  Get_all_department_json({this.errNum, this.status, this.result});

  Get_all_department_json.fromJson(Map<String, dynamic> json) {
    errNum = json['errNum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errNum'] = this.errNum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<Categories> categories;

  Result({this.categories});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['Categories'] != null) {
      categories = new List<Categories>();
      json['Categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['Categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String categoryName;
  int catId;
  String categoryImg;
  List<Departments> departments;

  Categories({this.categoryName, this.catId, this.departments,this.categoryImg});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryImg = json["category_img"];
    catId = json['cat_id'];
    if (json['Departments'] != null) {
      departments = new List<Departments>();
      json['Departments'].forEach((v) {
        departments.add(new Departments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['cat_id'] = this.catId;
    data["category_img"] = this.categoryImg;
    if (this.departments != null) {
      data['Departments'] = this.departments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departments {
  String depName;
  int depId;

  Departments({this.depName, this.depId});

  Departments.fromJson(Map<String, dynamic> json) {
    depName = json['dep_name'];
    depId = json['dep_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dep_name'] = this.depName;
    data['dep_id'] = this.depId;
    return data;
  }
}
