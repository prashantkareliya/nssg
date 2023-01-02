class AddContactDetailResponse {
  bool? success;
  Result? result;

  AddContactDetailResponse({this.success, this.result});

  AddContactDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.toJson();
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
  String? accountId;
  String? homephone;
  String? leadsource;
  String? otherphone;
  String? title;
  String? fax;
  String? department;
  String? birthday;
  String? email;
  String? contactId;
  String? assistant;
  String? secondaryemail;
  String? assistantphone;
  String? donotcall;
  String? emailoptout;
  String? assignedUserId;
  String? reference;
  String? notifyOwner;
  String? createdtime;
  String? modifiedtime;
  String? modifiedby;
  String? mailingstreet;
  String? otherstreet;
  String? mailingcity;
  String? othercity;
  String? mailingstate;
  String? otherstate;
  String? mailingzip;
  String? otherzip;
  String? mailingcountry;
  String? othercountry;
  String? mailingpobox;
  String? otherpobox;
  String? imagename;
  String? description;
  String? isconvertedfromlead;
  String? contactCompany;
  String? id;
  String? assignedUserName;

  Result(
      {this.salutationtype,
        this.firstname,
        this.contactNo,
        this.phone,
        this.lastname,
        this.mobile,
        this.accountId,
        this.homephone,
        this.leadsource,
        this.otherphone,
        this.title,
        this.fax,
        this.department,
        this.birthday,
        this.email,
        this.contactId,
        this.assistant,
        this.secondaryemail,
        this.assistantphone,
        this.donotcall,
        this.emailoptout,
        this.assignedUserId,
        this.reference,
        this.notifyOwner,
        this.createdtime,
        this.modifiedtime,
        this.modifiedby,
        this.mailingstreet,
        this.otherstreet,
        this.mailingcity,
        this.othercity,
        this.mailingstate,
        this.otherstate,
        this.mailingzip,
        this.otherzip,
        this.mailingcountry,
        this.othercountry,
        this.mailingpobox,
        this.otherpobox,
        this.imagename,
        this.description,
        this.isconvertedfromlead,
        this.contactCompany,
        this.id,
        this.assignedUserName});

  Result.fromJson(Map<String, dynamic> json) {
    salutationtype = json['salutationtype'];
    firstname = json['firstname'];
    contactNo = json['contact_no'];
    phone = json['phone'];
    lastname = json['lastname'];
    mobile = json['mobile'];
    accountId = json['account_id'];
    homephone = json['homephone'];
    leadsource = json['leadsource'];
    otherphone = json['otherphone'];
    title = json['title'];
    fax = json['fax'];
    department = json['department'];
    birthday = json['birthday'];
    email = json['email'];
    contactId = json['contact_id'];
    assistant = json['assistant'];
    secondaryemail = json['secondaryemail'];
    assistantphone = json['assistantphone'];
    donotcall = json['donotcall'];
    emailoptout = json['emailoptout'];
    assignedUserId = json['assigned_user_id'];
    reference = json['reference'];
    notifyOwner = json['notify_owner'];
    createdtime = json['createdtime'];
    modifiedtime = json['modifiedtime'];
    modifiedby = json['modifiedby'];
    mailingstreet = json['mailingstreet'];
    otherstreet = json['otherstreet'];
    mailingcity = json['mailingcity'];
    othercity = json['othercity'];
    mailingstate = json['mailingstate'];
    otherstate = json['otherstate'];
    mailingzip = json['mailingzip'];
    otherzip = json['otherzip'];
    mailingcountry = json['mailingcountry'];
    othercountry = json['othercountry'];
    mailingpobox = json['mailingpobox'];
    otherpobox = json['otherpobox'];
    imagename = json['imagename'];
    description = json['description'];
    isconvertedfromlead = json['isconvertedfromlead'];
    contactCompany = json['contact_company'];
    id = json['id'];
    assignedUserName = json['assigned_user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salutationtype'] = salutationtype;
    data['firstname'] = firstname;
    data['contact_no'] = contactNo;
    data['phone'] = phone;
    data['lastname'] = lastname;
    data['mobile'] = mobile;
    data['account_id'] = accountId;
    data['homephone'] = homephone;
    data['leadsource'] = leadsource;
    data['otherphone'] = otherphone;
    data['title'] = title;
    data['fax'] = fax;
    data['department'] = department;
    data['birthday'] = birthday;
    data['email'] = email;
    data['contact_id'] = contactId;
    data['assistant'] = assistant;
    data['secondaryemail'] = secondaryemail;
    data['assistantphone'] = assistantphone;
    data['donotcall'] = donotcall;
    data['emailoptout'] = emailoptout;
    data['assigned_user_id'] = assignedUserId;
    data['reference'] = reference;
    data['notify_owner'] = notifyOwner;
    data['createdtime'] = createdtime;
    data['modifiedtime'] = modifiedtime;
    data['modifiedby'] = modifiedby;
    data['mailingstreet'] = mailingstreet;
    data['otherstreet'] = otherstreet;
    data['mailingcity'] = mailingcity;
    data['othercity'] = othercity;
    data['mailingstate'] = mailingstate;
    data['otherstate'] = otherstate;
    data['mailingzip'] = mailingzip;
    data['otherzip'] = otherzip;
    data['mailingcountry'] = mailingcountry;
    data['othercountry'] = othercountry;
    data['mailingpobox'] = mailingpobox;
    data['otherpobox'] = otherpobox;
    data['imagename'] = imagename;
    data['description'] = description;
    data['isconvertedfromlead'] = isconvertedfromlead;
    data['contact_company'] = contactCompany;
    data['id'] = id;
    data['assigned_user_name'] = assignedUserName;
    return data;
  }
}