class ContactDetailData {
  String firstname;
  String lastname;
  String contact_company;
  String phone;
  String mobile;
  String email;
  String secondaryemail;
  String mailingstreet;
  String mailingcity;
  String mailingcountry;
  String mailingzip;
  String otherstreet;
  String othercity;
  String othercountry;
  String otherzip;
  String assigned_user_id;

  ContactDetailData(
    // this.salutationtype,
    this.firstname,
    this.lastname,
    this.contact_company,
    this.phone,
    this.mobile,
    this.email,
    this.secondaryemail,
    this.mailingstreet,
    this.mailingcity,
    this.mailingcountry,
    this.mailingzip,
    this.otherstreet,
    this.othercity,
    this.othercountry,
    this.otherzip,
    this.assigned_user_id,
  );

  Map toJson() => {
        //'salutationtype': salutationtype,
        'firstname': firstname,
        'lastname': lastname,
        'contact_company': contact_company,
        'phone': phone,
        'mobile': mobile,
        'email': email,
        'secondaryemail': secondaryemail,
        'mailingstreet': mailingstreet,
        'mailingcity': mailingcity,
        'mailingcountry': mailingcountry,
        'mailingzip': mailingzip,
        'otherstreet': otherstreet,
        'othercity': othercity,
        'othercountry': othercountry,
        'otherzip': otherzip,
        'assigned_user_id': assigned_user_id,
      };
}
