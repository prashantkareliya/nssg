class UpdateContactData {
  String salutationtype;
  String firstname;
  String contact_no;
  String phone;
  String lastname;
  String mobile;
  String account_id;
  String homephone;
  String leadsource;
  String otherphone;
  String title;
  String fax;
  String department;
  String birthday;
  String email;
  String contact_id;
  String assistant;
  String secondaryemail;
  String assistantphone;
  String donotcall;
  String emailoptout;
  String assigned_user_id;
  String reference;
  String notify_owner;
  String modifiedby;
  String isconvertedfromlead;
  String contact_company;
  String mailingstreet;
  String mailingcity;
  String mailingstate;
  String otherstate;
  String mailingzip;
  String mailingcountry;
  String mailingpobox;
  String otherpobox;
  String description;
  String imagename;
  String otherstreet;
  String othercity;
  String otherzip;
  String othercountry;
  String id;
  String assigned_user_name;

  UpdateContactData(
      this.salutationtype,
      this.firstname,
      this.contact_no,
      this.phone,
      this.lastname,
      this.mobile,
      this.account_id,
      this.homephone,
      this.leadsource,
      this.otherphone,
      this.title,
      this.fax,
      this.department,
      this.birthday,
      this.email,
      this.contact_id,
      this.assistant,
      this.secondaryemail,
      this.assistantphone,
      this.donotcall,
      this.emailoptout,
      this.assigned_user_id,
      this.reference,
      this.notify_owner,
      this.modifiedby,
      this.isconvertedfromlead,
      this.contact_company,
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
      this.assigned_user_name);

  Map toJson() => {
        'salutationtype': salutationtype,
        'firstname': firstname,
        'contact_no': contact_no,
        'phone': phone,
        'lastname': lastname,
        'mobile': mobile,
        'account_id': account_id,
        'homephone': homephone,
        'leadsource': leadsource,
        'otherphone': otherphone,
        'title': title,
        'fax': fax,
        'department': department,
        'birthday': birthday,
        'email': email,
        'contact_id': contact_id,
        'assistant': assistant,
        'secondaryemail': secondaryemail,
        'assistantphone': assistantphone,
        'donotcall': donotcall,
        'emailoptout': emailoptout,
        'assigned_user_id': assigned_user_id,
        'reference': reference,
        'notify_owner': notify_owner,
        'createdtime': modifiedby,
        'isconvertedfromlead': isconvertedfromlead,
        'contact_company': contact_company,
        'mailingstreet': mailingstreet,
        'mailingcity': mailingcity,
        'mailingstate': mailingstate,
        'otherstate': otherstate,
        'mailingzip': mailingzip,
        'mailingcountry': mailingcountry,
        'mailingpobox': mailingpobox,
        'otherpobox': otherpobox,
        'description': description,
        'imagename': imagename,
        'otherstreet': otherstreet,
        'othercity': othercity,
        'otherzip': otherzip,
        'othercountry': othercountry,
        'id': id,
        'assigned_user_name': assigned_user_name
      };
}
