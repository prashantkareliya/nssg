class UserData {
  bool? success;
  Result? result;
  String? status;
  String? msg;

  UserData({this.success, this.result, this.status, this.msg});

  UserData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['status'] = status;
    data['msg'] = msg;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionName'] = sessionName;
    data['userId'] = userId;
    data['Username'] = username;
    data['Firstname'] = firstname;
    data['Lastname'] = lastname;
    data['version'] = version;
    data['vtigerVersion'] = vtigerVersion;
    return data;
  }
}