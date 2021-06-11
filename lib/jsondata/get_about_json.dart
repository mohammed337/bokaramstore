class Get_about_json {
  int errNum;
  bool status;
  Result result;

  Get_about_json({this.errNum, this.status, this.result});

  Get_about_json.fromJson(Map<String, dynamic> json) {
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
  List<AllInfo> allInfo;

  Result({this.allInfo});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['all_info'] != null) {
      allInfo = new List<AllInfo>();
      json['all_info'].forEach((v) {
        allInfo.add(new AllInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allInfo != null) {
      data['all_info'] = this.allInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllInfo {
  String title;
  String content;

  AllInfo({this.title, this.content});

  AllInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
