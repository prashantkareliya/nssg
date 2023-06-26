class GetQuoteData {
  bool? success;
  List<Result>? result;
  String? error;

  GetQuoteData({this.success, this.result, this.error});

  GetQuoteData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    error = json["error"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class Result {
  String? quoteNo;
  String? subject;
  String? quotesEmail;
  String? quoteMobileNumber;
  String? quotestage;
  String? contactId;
  String? systemType;
  String? quotesCompany;
  String? shipStreet;
  String? shipCity;
  String? shipCountry;
  String? shipCode;
  String? id;
  String? contactName;
  String? createdDate;
  String? assignedUserName;
  String? quoteType;
  String? quotesContractId;

  Result({
    this.quoteNo,
    this.subject,
    this.quotesEmail,
    this.quoteMobileNumber,
    this.quotestage,
    this.contactId,
    this.systemType,
    this.quotesCompany,
    this.shipStreet,
    this.shipCity,
    this.shipCountry,
    this.shipCode,
    this.id,
    this.contactName,
    this.createdDate,
    this.assignedUserName,
    this.quoteType,
    this.quotesContractId
  });

  Result.fromJson(Map<String, dynamic> json) {
    quoteNo = json['quote_no'];
    subject = json['subject'];
    quotesEmail = json['quotes_email'];
    quoteMobileNumber = json['quote_mobile_number'];
    quotestage = json['quotestage'];
    contactId = json['contact_id'];
    systemType = json['system_type'];
    quotesCompany = json['quotes_company'];
    shipStreet = json['ship_street'];
    shipCity = json['ship_city'];
    shipCountry = json['ship_country'];
    shipCode = json['ship_code'];
    id = json['id'];
    contactName = json['contact_name'];
    createdDate = json['createdtime'];
    assignedUserName = json['assigned_user_name'];
    quoteType = json['quote_quote_type'];
    quotesContractId = json['quotes_contract_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quote_no'] = quoteNo;
    data['subject'] = subject;
    data['quotes_email'] = quotesEmail;
    data['quote_mobile_number'] = quoteMobileNumber;
    data['quotestage'] = quotestage;
    data['contact_id'] = contactId;
    data['system_type'] = systemType;
    data['quotes_company'] = quotesCompany;
    data['ship_street'] = shipStreet;
    data['ship_city'] = shipCity;
    data['ship_country'] = shipCountry;
    data['ship_code'] = shipCode;
    data['id'] = id;
    data['contact_name'] = contactName;
    data['createdtime'] = createdDate;
    data['assigned_user_name'] = assignedUserName;
    data['quote_quote_type'] = quoteType;
    data['quotes_contract_id'] = quotesContractId;
    return data;
  }
}
