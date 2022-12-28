class UserData {
  bool? success;
  Result? result;
  String? status;
  String? msg;

  UserData({this.success, this.result, this.status, this.msg});

  UserData.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    result = json['result'] ?? "";
    status = json['status'] ?? "";
    msg = json['msg'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['status'] = this.status;
    data['msg'] = this.msg;
    return data;
  }
}

class Result {
  String? sessionName;
  String? userId;
  String? username;
  String? firstname;
  String? lastname;
  String? version;
  String? vtigerVersion;

  Result(
      {this.sessionName,
        this.userId,
        this.username,
        this.firstname,
        this.lastname,
        this.version,
        this.vtigerVersion});

  Result.fromJson(Map<String, dynamic> json) {
    sessionName = json['sessionName'];
    userId = json['userId'];
    username = json['Username'];
    firstname = json['Firstname'];
    lastname = json['Lastname'];
    version = json['version'];
    vtigerVersion = json['vtigerVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionName'] = this.sessionName;
    data['userId'] = this.userId;
    data['Username'] = this.username;
    data['Firstname'] = this.firstname;
    data['Lastname'] = this.lastname;
    data['version'] = this.version;
    data['vtigerVersion'] = this.vtigerVersion;
    return data;
  }
}