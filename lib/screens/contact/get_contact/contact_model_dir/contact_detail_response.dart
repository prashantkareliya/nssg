class ContactDetail {
  bool? success;
  ContactDetailResult? result;

  ContactDetail({this.success, this.result});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? new ContactDetailResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ContactDetailResult {
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
  String? isconvertedfromlead;
  String? contactCompany;
  String? mailingstreet;
  String? mailingcity;
  String? mailingstate;
  String? otherstate;
  String? mailingzip;
  String? mailingcountry;
  String? mailingpobox;
  String? otherpobox;
  String? description;
  String? imagename;
  String? otherstreet;
  String? othercity;
  String? otherzip;
  String? othercountry;
  String? id;
  String? assignedUserName;

  ContactDetailResult(
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
        this.isconvertedfromlead,
        this.contactCompany,
        this.mailingstreet,
        this.mailingcity,
        this.mailingstate,
        this.otherstate,
        this.mailingzip,
        this.mailingcountry,
        this.mailingpobox,
        this.otherpobox,
        this.description,
        this.imagename,
        this.otherstreet,
        this.othercity,
        this.otherzip,
        this.othercountry,
        this.id,
        this.assignedUserName});

  ContactDetailResult.fromJson(Map<String, dynamic> json) {
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
    isconvertedfromlead = json['isconvertedfromlead'];
    contactCompany = json['contact_company'];
    mailingstreet = json['mailingstreet'];
    mailingcity = json['mailingcity'];
    mailingstate = json['mailingstate'];
    otherstate = json['otherstate'];
    mailingzip = json['mailingzip'];
    mailingcountry = json['mailingcountry'];
    mailingpobox = json['mailingpobox'];
    otherpobox = json['otherpobox'];
    description = json['description'];
    imagename = json['imagename'];
    otherstreet = json['otherstreet'];
    othercity = json['othercity'];
    otherzip = json['otherzip'];
    othercountry = json['othercountry'];
    id = json['id'];
    assignedUserName = json['assigned_user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salutationtype'] = this.salutationtype;
    data['firstname'] = this.firstname;
    data['contact_no'] = this.contactNo;
    data['phone'] = this.phone;
    data['lastname'] = this.lastname;
    data['mobile'] = this.mobile;
    data['account_id'] = this.accountId;
    data['homephone'] = this.homephone;
    data['leadsource'] = this.leadsource;
    data['otherphone'] = this.otherphone;
    data['title'] = this.title;
    data['fax'] = this.fax;
    data['department'] = this.department;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['contact_id'] = this.contactId;
    data['assistant'] = this.assistant;
    data['secondaryemail'] = this.secondaryemail;
    data['assistantphone'] = this.assistantphone;
    data['donotcall'] = this.donotcall;
    data['emailoptout'] = this.emailoptout;
    data['assigned_user_id'] = this.assignedUserId;
    data['reference'] = this.reference;
    data['notify_owner'] = this.notifyOwner;
    data['createdtime'] = this.createdtime;
    data['modifiedtime'] = this.modifiedtime;
    data['modifiedby'] = this.modifiedby;
    data['isconvertedfromlead'] = this.isconvertedfromlead;
    data['contact_company'] = this.contactCompany;
    data['mailingstreet'] = this.mailingstreet;
    data['mailingcity'] = this.mailingcity;
    data['mailingstate'] = this.mailingstate;
    data['otherstate'] = this.otherstate;
    data['mailingzip'] = this.mailingzip;
    data['mailingcountry'] = this.mailingcountry;
    data['mailingpobox'] = this.mailingpobox;
    data['otherpobox'] = this.otherpobox;
    data['description'] = this.description;
    data['imagename'] = this.imagename;
    data['otherstreet'] = this.otherstreet;
    data['othercity'] = this.othercity;
    data['otherzip'] = this.otherzip;
    data['othercountry'] = this.othercountry;
    data['id'] = this.id;
    data['assigned_user_name'] = this.assignedUserName;
    return data;
  }
}