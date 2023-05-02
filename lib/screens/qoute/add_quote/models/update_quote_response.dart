class UpdateQuoteResponse {
  bool? success;
  Result? result;

  UpdateQuoteResponse({this.success, this.result});

  UpdateQuoteResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  String? quoteNo;
  String? subject;
  String? potentialId;
  String? quotestage;
  String? validtill;
  String? contactId;
  String? carrier;
  String? hdnSubTotal;
  String? shipping;
  String? assignedUserId1;
  String? txtAdjustment;
  String? hdnGrandTotal;
  String? hdnTaxType;
  String? hdnDiscountPercent;
  String? hdnDiscountAmount;
  String? hdnSHAmount;
  String? accountId;
  String? assignedUserId;
  String? createdtime;
  String? modifiedtime;
  String? modifiedby;
  String? currencyId;
  String? conversionRate;
  String? billStreet;
  String? shipStreet;
  String? billCity;
  String? shipCity;
  String? billState;
  String? shipState;
  String? billCode;
  String? shipCode;
  String? billCountry;
  String? shipCountry;
  String? billPobox;
  String? shipPobox;
  String? description;
  String? termsConditions;
  String? productid;
  String? quantity;
  String? listprice;
  String? comment;
  String? discountAmount;
  String? discountPercent;
  String? tax1;
  String? tax2;
  String? tax3;
  String? preTaxTotal;
  String? hdnSHPercent;
  String? siteAddressId;
  String? quotesTerms;
  String? costprice;
  String? hdnprofitTotal;
  String? markup;
  String? issueNumber;
  String? gradeNumber;
  String? systemType;
  String? signallingType;
  String? premisesType;
  String? projectManager;
  String? quotesEmail;
  String? quotesTemplateOptions;
  String? quoteRelatedId;
  String? productLocationTitle;
  String? floorPlanDocs;
  String? quotesCompany;
  String? installationtype;
  String? installation;
  String? hdnsubTotal;
  String? hdndiscountTotal;
  String? quoteTelephoneNumber;
  String? quoteMobileNumber;
  String? isQuotesConfirm;
  String? quotesPayment;
  String? isQuotesPaymentConfirm;
  String? quotesDepositeAmount;
  String? quotesDepoReceivedAmount;
  String? quoteEmailReminder;
  String? quoteReminderEmailSentLog;
  String? isKeyholderConfirm;
  String? isMaintenanceConConfirm;
  String? isPoliceAppliConfirm;
  String? quoteCorrespondencesDocs;
  String? quoteQuoteType;
  String? quotesContractId;
  String? quoteStopEmailDocReminder;
  String? quotePriorityLevel;
  String? quoteWorksSchedule;
  String? quoteNoOfEngineer;
  String? quoteReqToCompleteWork;
  String? id;
  String? contactName;
  String? assignedUserName;
  String? projectManagerName;
  List<LineItems>? lineItems;

  Result(
      {this.quoteNo,
        this.subject,
        this.potentialId,
        this.quotestage,
        this.validtill,
        this.contactId,
        this.carrier,
        this.hdnSubTotal,
        this.shipping,
        this.assignedUserId1,
        this.txtAdjustment,
        this.hdnGrandTotal,
        this.hdnTaxType,
        this.hdnDiscountPercent,
        this.hdnDiscountAmount,
        this.hdnSHAmount,
        this.accountId,
        this.assignedUserId,
        this.createdtime,
        this.modifiedtime,
        this.modifiedby,
        this.currencyId,
        this.conversionRate,
        this.billStreet,
        this.shipStreet,
        this.billCity,
        this.shipCity,
        this.billState,
        this.shipState,
        this.billCode,
        this.shipCode,
        this.billCountry,
        this.shipCountry,
        this.billPobox,
        this.shipPobox,
        this.description,
        this.termsConditions,
        this.productid,
        this.quantity,
        this.listprice,
        this.comment,
        this.discountAmount,
        this.discountPercent,
        this.tax1,
        this.tax2,
        this.tax3,
        this.preTaxTotal,
        this.hdnSHPercent,
        this.siteAddressId,
        this.quotesTerms,
        this.costprice,
        this.hdnprofitTotal,
        this.markup,
        this.issueNumber,
        this.gradeNumber,
        this.systemType,
        this.signallingType,
        this.premisesType,
        this.projectManager,
        this.quotesEmail,
        this.quotesTemplateOptions,
        this.quoteRelatedId,
        this.productLocationTitle,
        this.floorPlanDocs,
        this.quotesCompany,
        this.installationtype,
        this.installation,
        this.hdnsubTotal,
        this.hdndiscountTotal,
        this.quoteTelephoneNumber,
        this.quoteMobileNumber,
        this.isQuotesConfirm,
        this.quotesPayment,
        this.isQuotesPaymentConfirm,
        this.quotesDepositeAmount,
        this.quotesDepoReceivedAmount,
        this.quoteEmailReminder,
        this.quoteReminderEmailSentLog,
        this.isKeyholderConfirm,
        this.isMaintenanceConConfirm,
        this.isPoliceAppliConfirm,
        this.quoteCorrespondencesDocs,
        this.quoteQuoteType,
        this.quotesContractId,
        this.quoteStopEmailDocReminder,
        this.quotePriorityLevel,
        this.quoteWorksSchedule,
        this.quoteNoOfEngineer,
        this.quoteReqToCompleteWork,
        this.id,
        this.contactName,
        this.assignedUserName,
        this.projectManagerName,
        this.lineItems});

  Result.fromJson(Map<String, dynamic> json) {
    quoteNo = json['quote_no'];
    subject = json['subject'];
    potentialId = json['potential_id'];
    quotestage = json['quotestage'];
    validtill = json['validtill'];
    contactId = json['contact_id'];
    carrier = json['carrier'];
    hdnSubTotal = json['hdnSubTotal'];
    shipping = json['shipping'];
    assignedUserId1 = json['assigned_user_id1'];
    txtAdjustment = json['txtAdjustment'];
    hdnGrandTotal = json['hdnGrandTotal'];
    hdnTaxType = json['hdnTaxType'];
    hdnDiscountPercent = json['hdnDiscountPercent'];
    hdnDiscountAmount = json['hdnDiscountAmount'];
    hdnSHAmount = json['hdnS_H_Amount'];
    accountId = json['account_id'];
    assignedUserId = json['assigned_user_id'];
    createdtime = json['createdtime'];
    modifiedtime = json['modifiedtime'];
    modifiedby = json['modifiedby'];
    currencyId = json['currency_id'];
    conversionRate = json['conversion_rate'];
    billStreet = json['bill_street'];
    shipStreet = json['ship_street'];
    billCity = json['bill_city'];
    shipCity = json['ship_city'];
    billState = json['bill_state'];
    shipState = json['ship_state'];
    billCode = json['bill_code'];
    shipCode = json['ship_code'];
    billCountry = json['bill_country'];
    shipCountry = json['ship_country'];
    billPobox = json['bill_pobox'];
    shipPobox = json['ship_pobox'];
    description = json['description'];
    termsConditions = json['terms_conditions'];
    productid = json['productid'];
    quantity = json['quantity'];
    listprice = json['listprice'];
    comment = json['comment'];
    discountAmount = json['discount_amount'];
    discountPercent = json['discount_percent'];
    tax1 = json['tax1'];
    tax2 = json['tax2'];
    tax3 = json['tax3'];
    preTaxTotal = json['pre_tax_total'];
    hdnSHPercent = json['hdnS_H_Percent'];
    siteAddressId = json['site_address_id'];
    quotesTerms = json['quotes_terms'];
    costprice = json['costprice'];
    hdnprofitTotal = json['hdnprofitTotal'];
    markup = json['markup'];
    issueNumber = json['issue_number'];
    gradeNumber = json['grade_number'];
    systemType = json['system_type'];
    signallingType = json['signalling_type'];
    premisesType = json['premises_type'];
    projectManager = json['project_manager'];
    quotesEmail = json['quotes_email'];
    quotesTemplateOptions = json['quotes_template_options'];
    quoteRelatedId = json['quote_related_id'];
    productLocationTitle = json['product_location_title'];
    floorPlanDocs = json['floor_plan_docs'];
    quotesCompany = json['quotes_company'];
    installationtype = json['installationtype'];
    installation = json['installation'];
    hdnsubTotal = json['hdnsubTotal'];
    hdndiscountTotal = json['hdndiscountTotal'];
    quoteTelephoneNumber = json['quote_telephone_number'];
    quoteMobileNumber = json['quote_mobile_number'];
    isQuotesConfirm = json['is_quotes_confirm'];
    quotesPayment = json['quotes_payment'];
    isQuotesPaymentConfirm = json['is_quotes_payment_confirm'];
    quotesDepositeAmount = json['quotes_deposite_amount'];
    quotesDepoReceivedAmount = json['quotes_depo_received_amount'];
    quoteEmailReminder = json['quote_email_reminder'];
    quoteReminderEmailSentLog = json['quote_reminder_email_sent_log'];
    isKeyholderConfirm = json['is_keyholder_confirm'];
    isMaintenanceConConfirm = json['is_maintenance_con_confirm'];
    isPoliceAppliConfirm = json['is_police_appli_confirm'];
    quoteCorrespondencesDocs = json['quote_correspondences_docs'];
    quoteQuoteType = json['quote_quote_type'];
    quotesContractId = json['quotes_contract_id'];
    quoteStopEmailDocReminder = json['quote_stop_email_doc_reminder'];
    quotePriorityLevel = json['quote_priority_level'];
    quoteWorksSchedule = json['quote_works_schedule'];
    quoteNoOfEngineer = json['quote_no_of_engineer'];
    quoteReqToCompleteWork = json['quote_req_to_complete_work'];
    id = json['id'];
    contactName = json['contact_name'];
    assignedUserName = json['assigned_user_name'];
    projectManagerName = json['project_manager_name'];
    if (json['LineItems'] != null) {
      lineItems = <LineItems>[];
      json['LineItems'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_no'] = this.quoteNo;
    data['subject'] = this.subject;
    data['potential_id'] = this.potentialId;
    data['quotestage'] = this.quotestage;
    data['validtill'] = this.validtill;
    data['contact_id'] = this.contactId;
    data['carrier'] = this.carrier;
    data['hdnSubTotal'] = this.hdnSubTotal;
    data['shipping'] = this.shipping;
    data['assigned_user_id1'] = this.assignedUserId1;
    data['txtAdjustment'] = this.txtAdjustment;
    data['hdnGrandTotal'] = this.hdnGrandTotal;
    data['hdnTaxType'] = this.hdnTaxType;
    data['hdnDiscountPercent'] = this.hdnDiscountPercent;
    data['hdnDiscountAmount'] = this.hdnDiscountAmount;
    data['hdnS_H_Amount'] = this.hdnSHAmount;
    data['account_id'] = this.accountId;
    data['assigned_user_id'] = this.assignedUserId;
    data['createdtime'] = this.createdtime;
    data['modifiedtime'] = this.modifiedtime;
    data['modifiedby'] = this.modifiedby;
    data['currency_id'] = this.currencyId;
    data['conversion_rate'] = this.conversionRate;
    data['bill_street'] = this.billStreet;
    data['ship_street'] = this.shipStreet;
    data['bill_city'] = this.billCity;
    data['ship_city'] = this.shipCity;
    data['bill_state'] = this.billState;
    data['ship_state'] = this.shipState;
    data['bill_code'] = this.billCode;
    data['ship_code'] = this.shipCode;
    data['bill_country'] = this.billCountry;
    data['ship_country'] = this.shipCountry;
    data['bill_pobox'] = this.billPobox;
    data['ship_pobox'] = this.shipPobox;
    data['description'] = this.description;
    data['terms_conditions'] = this.termsConditions;
    data['productid'] = this.productid;
    data['quantity'] = this.quantity;
    data['listprice'] = this.listprice;
    data['comment'] = this.comment;
    data['discount_amount'] = this.discountAmount;
    data['discount_percent'] = this.discountPercent;
    data['tax1'] = this.tax1;
    data['tax2'] = this.tax2;
    data['tax3'] = this.tax3;
    data['pre_tax_total'] = this.preTaxTotal;
    data['hdnS_H_Percent'] = this.hdnSHPercent;
    data['site_address_id'] = this.siteAddressId;
    data['quotes_terms'] = this.quotesTerms;
    data['costprice'] = this.costprice;
    data['hdnprofitTotal'] = this.hdnprofitTotal;
    data['markup'] = this.markup;
    data['issue_number'] = this.issueNumber;
    data['grade_number'] = this.gradeNumber;
    data['system_type'] = this.systemType;
    data['signalling_type'] = this.signallingType;
    data['premises_type'] = this.premisesType;
    data['project_manager'] = this.projectManager;
    data['quotes_email'] = this.quotesEmail;
    data['quotes_template_options'] = this.quotesTemplateOptions;
    data['quote_related_id'] = this.quoteRelatedId;
    data['product_location_title'] = this.productLocationTitle;
    data['floor_plan_docs'] = this.floorPlanDocs;
    data['quotes_company'] = this.quotesCompany;
    data['installationtype'] = this.installationtype;
    data['installation'] = this.installation;
    data['hdnsubTotal'] = this.hdnsubTotal;
    data['hdndiscountTotal'] = this.hdndiscountTotal;
    data['quote_telephone_number'] = this.quoteTelephoneNumber;
    data['quote_mobile_number'] = this.quoteMobileNumber;
    data['is_quotes_confirm'] = this.isQuotesConfirm;
    data['quotes_payment'] = this.quotesPayment;
    data['is_quotes_payment_confirm'] = this.isQuotesPaymentConfirm;
    data['quotes_deposite_amount'] = this.quotesDepositeAmount;
    data['quotes_depo_received_amount'] = this.quotesDepoReceivedAmount;
    data['quote_email_reminder'] = this.quoteEmailReminder;
    data['quote_reminder_email_sent_log'] = this.quoteReminderEmailSentLog;
    data['is_keyholder_confirm'] = this.isKeyholderConfirm;
    data['is_maintenance_con_confirm'] = this.isMaintenanceConConfirm;
    data['is_police_appli_confirm'] = this.isPoliceAppliConfirm;
    data['quote_correspondences_docs'] = this.quoteCorrespondencesDocs;
    data['quote_quote_type'] = this.quoteQuoteType;
    data['quotes_contract_id'] = this.quotesContractId;
    data['quote_stop_email_doc_reminder'] = this.quoteStopEmailDocReminder;
    data['quote_priority_level'] = this.quotePriorityLevel;
    data['quote_works_schedule'] = this.quoteWorksSchedule;
    data['quote_no_of_engineer'] = this.quoteNoOfEngineer;
    data['quote_req_to_complete_work'] = this.quoteReqToCompleteWork;
    data['id'] = this.id;
    data['contact_name'] = this.contactName;
    data['assigned_user_name'] = this.assignedUserName;
    data['project_manager_name'] = this.projectManagerName;
    if (this.lineItems != null) {
      data['LineItems'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
  String? parentId;
  String? productid;
  String? sequenceNo;
  String? quantity;
  String? listprice;
  String? discountPercent;
  String? discountAmount;
  String? comment;
  String? description;
  String? incrementondel;
  String? tax1;
  String? tax2;
  String? tax3;
  String? productLocation;
  String? productLocationTitle;
  String? costprice;
  String? extQty;
  String? requiredDocument;
  String? proShortDescription;
  String? id;
  String? prodName;

  LineItems(
      {this.parentId,
        this.productid,
        this.sequenceNo,
        this.quantity,
        this.listprice,
        this.discountPercent,
        this.discountAmount,
        this.comment,
        this.description,
        this.incrementondel,
        this.tax1,
        this.tax2,
        this.tax3,
        this.productLocation,
        this.productLocationTitle,
        this.costprice,
        this.extQty,
        this.requiredDocument,
        this.proShortDescription,
        this.id,
        this.prodName});

  LineItems.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    productid = json['productid'];
    sequenceNo = json['sequence_no'];
    quantity = json['quantity'];
    listprice = json['listprice'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    comment = json['comment'];
    description = json['description'];
    incrementondel = json['incrementondel'];
    tax1 = json['tax1'];
    tax2 = json['tax2'];
    tax3 = json['tax3'];
    productLocation = json['product_location'];
    productLocationTitle = json['product_location_title'];
    costprice = json['costprice'];
    extQty = json['ext_qty'];
    requiredDocument = json['required_document'];
    proShortDescription = json['pro_short_description'];
    id = json['id'];
    prodName = json['prod_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['productid'] = this.productid;
    data['sequence_no'] = this.sequenceNo;
    data['quantity'] = this.quantity;
    data['listprice'] = this.listprice;
    data['discount_percent'] = this.discountPercent;
    data['discount_amount'] = this.discountAmount;
    data['comment'] = this.comment;
    data['description'] = this.description;
    data['incrementondel'] = this.incrementondel;
    data['tax1'] = this.tax1;
    data['tax2'] = this.tax2;
    data['tax3'] = this.tax3;
    data['product_location'] = this.productLocation;
    data['product_location_title'] = this.productLocationTitle;
    data['costprice'] = this.costprice;
    data['ext_qty'] = this.extQty;
    data['required_document'] = this.requiredDocument;
    data['pro_short_description'] = this.proShortDescription;
    data['id'] = this.id;
    data['prod_name'] = this.prodName;
    return data;
  }
}