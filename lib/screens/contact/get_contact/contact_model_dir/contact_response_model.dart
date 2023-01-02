class GetContactData {
  bool? success;
  List<Result>? result;

  GetContactData({this.success, this.result});

  GetContactData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salutationtype'] = salutationtype;
    data['firstname'] = firstname;
    data['contact_no'] = contactNo;
    data['phone'] = phone;
    data['lastname'] = lastname;
    data['mobile'] = mobile;
    data['email'] = email;
    data['contact_company'] = contactCompany;
    data['mailingstreet'] = mailingstreet;
    data['mailingcity'] = mailingcity;
    data['mailingcountry'] = mailingcountry;
    data['mailingzip'] = mailingzip;
    data['otherstreet'] = otherstreet;
    data['othercity'] = othercity;
    data['othercountry'] = othercountry;
    data['otherzip'] = otherzip;
    data['id'] = id;
    data['contact_name'] = contactName;
    return data;
  }
}