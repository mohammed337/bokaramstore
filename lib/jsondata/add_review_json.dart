class Add_review_json {
  String message;
  int codenum;
  bool status;
  Result result;

  Add_review_json({this.message, this.codenum, this.status, this.result});

  Add_review_json.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    codenum = json['codenum'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['codenum'] = this.codenum;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int totalRate;

  Result({this.totalRate});

  Result.fromJson(Map<String, dynamic> json) {
    totalRate = json['total_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_rate'] = this.totalRate;
    return data;
  }
}
