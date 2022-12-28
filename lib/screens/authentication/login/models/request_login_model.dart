class LoginRequest {
  String? username;
  String? password;
  String? accesskey;

  LoginRequest({
    this.username,
    this.password,
    this.accesskey,
  });

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    accesskey = json['accesskey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['accesskey'] = this.accesskey;
    return data;
  }
}
