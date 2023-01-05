class ContactDetail {
  bool? success;
  ContactsDetail? contactsDetail;

  ContactDetail({this.success, this.contactsDetail});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    contactsDetail =
    json['result'] != null ? ContactsDetail.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (contactsDetail != null) {
      data['result'] = contactsDetail!.toJson();
    }
    return data;
  }
}

class ContactsDetail {
  String? userName;
  String? isAdmin;
  String? userPassword;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? roleid;
  String? email1;
  String? status;
  String? activityView;
  String? leadView;
  String? hourFormat;
  String? endHour;
  String? startHour;
  String? title;
  String? phoneWork;
  String? department;
  String? phoneMobile;
  String? reportsToId;
  String? phoneOther;
  String? email2;
  String? phoneFax;
  String? secondaryemail;
  String? phoneHome;
  String? dateFormat;
  String? signature;
  String? description;
  String? addressStreet;
  String? addressCity;
  String? addressState;
  String? addressPostalcode;
  String? addressCountry;
  String? accesskey;
  String? timeZone;
  String? currencyId;
  String? currencyGroupingPattern;
  String? currencyDecimalSeparator;
  String? currencyGroupingSeparator;
  String? currencySymbolPlacement;
  String? imagename;
  String? internalMailer;
  String? theme;
  String? language;
  String? reminderInterval;
  String? phoneCrmExtension;
  String? noOfCurrencyDecimals;
  String? truncateTrailingZeros;
  String? dayoftheweek;
  String? callduration;
  String? othereventduration;
  String? calendarsharedtype;
  String? defaultRecordView;
  String? leftpanelhide;
  String? rowheight;
  String? defaulteventstatus;
  String? defaultactivitytype;
  String? hidecompletedevents;
  String? isOwner;
  String? vtigerUserSystemtype;
  String? vtigerUserMultiSystemtype;
  String? vtigerUserLoginPin;
  String? id;

  ContactsDetail(
      {this.userName,
        this.isAdmin,
        this.userPassword,
        this.confirmPassword,
        this.firstName,
        this.lastName,
        this.roleid,
        this.email1,
        this.status,
        this.activityView,
        this.leadView,
        this.hourFormat,
        this.endHour,
        this.startHour,
        this.title,
        this.phoneWork,
        this.department,
        this.phoneMobile,
        this.reportsToId,
        this.phoneOther,
        this.email2,
        this.phoneFax,
        this.secondaryemail,
        this.phoneHome,
        this.dateFormat,
        this.signature,
        this.description,
        this.addressStreet,
        this.addressCity,
        this.addressState,
        this.addressPostalcode,
        this.addressCountry,
        this.accesskey,
        this.timeZone,
        this.currencyId,
        this.currencyGroupingPattern,
        this.currencyDecimalSeparator,
        this.currencyGroupingSeparator,
        this.currencySymbolPlacement,
        this.imagename,
        this.internalMailer,
        this.theme,
        this.language,
        this.reminderInterval,
        this.phoneCrmExtension,
        this.noOfCurrencyDecimals,
        this.truncateTrailingZeros,
        this.dayoftheweek,
        this.callduration,
        this.othereventduration,
        this.calendarsharedtype,
        this.defaultRecordView,
        this.leftpanelhide,
        this.rowheight,
        this.defaulteventstatus,
        this.defaultactivitytype,
        this.hidecompletedevents,
        this.isOwner,
        this.vtigerUserSystemtype,
        this.vtigerUserMultiSystemtype,
        this.vtigerUserLoginPin,
        this.id});

  ContactsDetail.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    isAdmin = json['is_admin'];
    userPassword = json['user_password'];
    confirmPassword = json['confirm_password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    roleid = json['roleid'];
    email1 = json['email1'];
    status = json['status'];
    activityView = json['activity_view'];
    leadView = json['lead_view'];
    hourFormat = json['hour_format'];
    endHour = json['end_hour'];
    startHour = json['start_hour'];
    title = json['title'];
    phoneWork = json['phone_work'];
    department = json['department'];
    phoneMobile = json['phone_mobile'];
    reportsToId = json['reports_to_id'];
    phoneOther = json['phone_other'];
    email2 = json['email2'];
    phoneFax = json['phone_fax'];
    secondaryemail = json['secondaryemail'];
    phoneHome = json['phone_home'];
    dateFormat = json['date_format'];
    signature = json['signature'];
    description = json['description'];
    addressStreet = json['address_street'];
    addressCity = json['address_city'];
    addressState = json['address_state'];
    addressPostalcode = json['address_postalcode'];
    addressCountry = json['address_country'];
    accesskey = json['accesskey'];
    timeZone = json['time_zone'];
    currencyId = json['currency_id'];
    currencyGroupingPattern = json['currency_grouping_pattern'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyGroupingSeparator = json['currency_grouping_separator'];
    currencySymbolPlacement = json['currency_symbol_placement'];
    imagename = json['imagename'];
    internalMailer = json['internal_mailer'];
    theme = json['theme'];
    language = json['language'];
    reminderInterval = json['reminder_interval'];
    phoneCrmExtension = json['phone_crm_extension'];
    noOfCurrencyDecimals = json['no_of_currency_decimals'];
    truncateTrailingZeros = json['truncate_trailing_zeros'];
    dayoftheweek = json['dayoftheweek'];
    callduration = json['callduration'];
    othereventduration = json['othereventduration'];
    calendarsharedtype = json['calendarsharedtype'];
    defaultRecordView = json['default_record_view'];
    leftpanelhide = json['leftpanelhide'];
    rowheight = json['rowheight'];
    defaulteventstatus = json['defaulteventstatus'];
    defaultactivitytype = json['defaultactivitytype'];
    hidecompletedevents = json['hidecompletedevents'];
    isOwner = json['is_owner'];
    vtigerUserSystemtype = json['vtiger_user_systemtype'];
    vtigerUserMultiSystemtype = json['vtiger_user_multi_systemtype'];
    vtigerUserLoginPin = json['vtiger_user_login_pin'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_name'] = userName;
    data['is_admin'] = isAdmin;
    data['user_password'] = userPassword;
    data['confirm_password'] = confirmPassword;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['roleid'] = roleid;
    data['email1'] = email1;
    data['status'] = status;
    data['activity_view'] = activityView;
    data['lead_view'] = leadView;
    data['hour_format'] = hourFormat;
    data['end_hour'] = endHour;
    data['start_hour'] = startHour;
    data['title'] = title;
    data['phone_work'] = phoneWork;
    data['department'] = department;
    data['phone_mobile'] = phoneMobile;
    data['reports_to_id'] = reportsToId;
    data['phone_other'] = phoneOther;
    data['email2'] = email2;
    data['phone_fax'] = phoneFax;
    data['secondaryemail'] = secondaryemail;
    data['phone_home'] = phoneHome;
    data['date_format'] = dateFormat;
    data['signature'] = signature;
    data['description'] = description;
    data['address_street'] = addressStreet;
    data['address_city'] = addressCity;
    data['address_state'] = addressState;
    data['address_postalcode'] = addressPostalcode;
    data['address_country'] = addressCountry;
    data['accesskey'] = accesskey;
    data['time_zone'] = timeZone;
    data['currency_id'] = currencyId;
    data['currency_grouping_pattern'] = currencyGroupingPattern;
    data['currency_decimal_separator'] = currencyDecimalSeparator;
    data['currency_grouping_separator'] = currencyGroupingSeparator;
    data['currency_symbol_placement'] = currencySymbolPlacement;
    data['imagename'] = imagename;
    data['internal_mailer'] = internalMailer;
    data['theme'] = theme;
    data['language'] = language;
    data['reminder_interval'] = reminderInterval;
    data['phone_crm_extension'] = phoneCrmExtension;
    data['no_of_currency_decimals'] = noOfCurrencyDecimals;
    data['truncate_trailing_zeros'] = truncateTrailingZeros;
    data['dayoftheweek'] = dayoftheweek;
    data['callduration'] = callduration;
    data['othereventduration'] = othereventduration;
    data['calendarsharedtype'] = calendarsharedtype;
    data['default_record_view'] = defaultRecordView;
    data['leftpanelhide'] = leftpanelhide;
    data['rowheight'] = rowheight;
    data['defaulteventstatus'] = defaulteventstatus;
    data['defaultactivitytype'] = defaultactivitytype;
    data['hidecompletedevents'] = hidecompletedevents;
    data['is_owner'] = isOwner;
    data['vtiger_user_systemtype'] = vtigerUserSystemtype;
    data['vtiger_user_multi_systemtype'] = vtigerUserMultiSystemtype;
    data['vtiger_user_login_pin'] = vtigerUserLoginPin;
    data['id'] = id;
    return data;
  }
}