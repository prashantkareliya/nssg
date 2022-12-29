class GetContactData {
  bool? success;
  List<Result>? result;

  GetContactData({this.success, this.result});

  GetContactData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? salutationtype;
  String? firstname;
  String? contactNo;
  String? phone;
  String? lastname;
  String? mobile;
  String? email;
  String? contactCompany;
  String? mailingstreet;
  String? mailingcity;
  String? mailingcountry;
  String? mailingzip;
  String? otherstreet;
  String? othercity;
  String? othercountry;
  String? otherzip;
  String? id;
  String? contactName;

  Result(
      {this.salutationtype,
        this.firstname,
        this.contactNo,
        this.phone,
        this.lastname,
        this.mobile,
        this.email,
        this.contactCompany,
        this.mailingstreet,
        this.mailingcity,
        this.mailingcountry,
        this.mailingzip,
        this.otherstreet,
        this.othercity,
        this.othercountry,
        this.otherzip,
        this.id,
        this.contactName});

  Result.fromJson(Map<String, dynamic> json) {
    salutationtype = json['salutationtype'];
    firstname = json['firstname'];
    contactNo = json['contact_no'];
    phone = json['phone'];
    lastname = json['lastname'];
    mobile = json['mobile'];
    email = json['email'];
    contactCompany = json['contact_company'];
    mailingstreet = json['mailingstreet'];
    mailingcity = json['mailingcity'];
    mailingcountry = json['mailingcountry'];
    mailingzip = json['mailingzip'];
    otherstreet = json['otherstreet'];
    othercity = json['othercity'];
    othercountry = json['othercountry'];
    otherzip = json['otherzip'];
    id = json['id'];
    contactName = json['contact_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salutationtype'] = this.salutationtype;
    data['firstname'] = this.firstname;
    data['contact_no'] = this.contactNo;
    data['phone'] = this.phone;
    data['lastname'] = this.lastname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['contact_company'] = this.contactCompany;
    data['mailingstreet'] = this.mailingstreet;
    data['mailingcity'] = this.mailingcity;
    data['mailingcountry'] = this.mailingcountry;
    data['mailingzip'] = this.mailingzip;
    data['otherstreet'] = this.otherstreet;
    data['othercity'] = this.othercity;
    data['othercountry'] = this.othercountry;
    data['otherzip'] = this.otherzip;
    data['id'] = this.id;
    data['contact_name'] = this.contactName;
    return data;
  }
}