class CopyQuoteResponse {
  bool? success;
  Result? result;

  CopyQuoteResponse({this.success, this.result});

  CopyQuoteResponse.fromJson(Map<String, dynamic> json) {
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
  String? quotePoNumber;
  String? isRequestNewQuote;
  String? quoteGradeOfNoti;
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
        this.quotePoNumber,
        this.isRequestNewQuote,
        this.quoteGradeOfNoti,
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
    quotePoNumber = json['quote_po_number'];
    isRequestNewQuote = json['is_request_new_quote'];
    quoteGradeOfNoti = json['quote_grade_of_noti'];
    id = json['id'];
    contactName = json['contact_name'];
    assignedUserName = json['assigned_user_name'];
    projectManagerName = json['project_manager_name'];
    if (json['LineItems'] != null) {
      lineItems = <LineItems>[];
      json['LineItems'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quote_no'] = quoteNo;
    data['subject'] = subject;
    data['potential_id'] = potentialId;
    data['quotestage'] = quotestage;
    data['validtill'] = validtill;
    data['contact_id'] = contactId;
    data['carrier'] = carrier;
    data['hdnSubTotal'] = hdnSubTotal;
    data['shipping'] = shipping;
    data['assigned_user_id1'] = assignedUserId1;
    data['txtAdjustment'] = txtAdjustment;
    data['hdnGrandTotal'] = hdnGrandTotal;
    data['hdnTaxType'] = hdnTaxType;
    data['hdnDiscountPercent'] = hdnDiscountPercent;
    data['hdnDiscountAmount'] = hdnDiscountAmount;
    data['hdnS_H_Amount'] = hdnSHAmount;
    data['account_id'] = accountId;
    data['assigned_user_id'] = assignedUserId;
    data['createdtime'] = createdtime;
    data['modifiedtime'] = modifiedtime;
    data['modifiedby'] = modifiedby;
    data['currency_id'] = currencyId;
    data['conversion_rate'] = conversionRate;
    data['bill_street'] = billStreet;
    data['ship_street'] = shipStreet;
    data['bill_city'] = billCity;
    data['ship_city'] = shipCity;
    data['bill_state'] = billState;
    data['ship_state'] = shipState;
    data['bill_code'] = billCode;
    data['ship_code'] = shipCode;
    data['bill_country'] = billCountry;
    data['ship_country'] = shipCountry;
    data['bill_pobox'] = billPobox;
    data['ship_pobox'] = shipPobox;
    data['description'] = description;
    data['terms_conditions'] = termsConditions;
    data['productid'] = productid;
    data['quantity'] = quantity;
    data['listprice'] = listprice;
    data['comment'] = comment;
    data['discount_amount'] = discountAmount;
    data['discount_percent'] = discountPercent;
    data['tax1'] = tax1;
    data['tax2'] = tax2;
    data['tax3'] = tax3;
    data['pre_tax_total'] = preTaxTotal;
    data['hdnS_H_Percent'] = hdnSHPercent;
    data['site_address_id'] = siteAddressId;
    data['quotes_terms'] = quotesTerms;
    data['costprice'] = costprice;
    data['hdnprofitTotal'] = hdnprofitTotal;
    data['markup'] = markup;
    data['issue_number'] = issueNumber;
    data['grade_number'] = gradeNumber;
    data['system_type'] = systemType;
    data['signalling_type'] = signallingType;
    data['premises_type'] = premisesType;
    data['project_manager'] = projectManager;
    data['quotes_email'] = quotesEmail;
    data['quotes_template_options'] = quotesTemplateOptions;
    data['quote_related_id'] = quoteRelatedId;
    data['product_location_title'] = productLocationTitle;
    data['floor_plan_docs'] = floorPlanDocs;
    data['quotes_company'] = quotesCompany;
    data['installationtype'] = installationtype;
    data['installation'] = installation;
    data['hdnsubTotal'] = hdnsubTotal;
    data['hdndiscountTotal'] = hdndiscountTotal;
    data['quote_telephone_number'] = quoteTelephoneNumber;
    data['quote_mobile_number'] = quoteMobileNumber;
    data['is_quotes_confirm'] = isQuotesConfirm;
    data['quotes_payment'] = quotesPayment;
    data['is_quotes_payment_confirm'] = isQuotesPaymentConfirm;
    data['quotes_deposite_amount'] = quotesDepositeAmount;
    data['quotes_depo_received_amount'] = quotesDepoReceivedAmount;
    data['quote_email_reminder'] = quoteEmailReminder;
    data['quote_reminder_email_sent_log'] = quoteReminderEmailSentLog;
    data['is_keyholder_confirm'] = isKeyholderConfirm;
    data['is_maintenance_con_confirm'] = isMaintenanceConConfirm;
    data['is_police_appli_confirm'] = isPoliceAppliConfirm;
    data['quote_correspondences_docs'] = quoteCorrespondencesDocs;
    data['quote_quote_type'] = quoteQuoteType;
    data['quotes_contract_id'] = quotesContractId;
    data['quote_stop_email_doc_reminder'] = quoteStopEmailDocReminder;
    data['quote_priority_level'] = quotePriorityLevel;
    data['quote_works_schedule'] = quoteWorksSchedule;
    data['quote_no_of_engineer'] = quoteNoOfEngineer;
    data['quote_req_to_complete_work'] = quoteReqToCompleteWork;
    data['quote_po_number'] = quotePoNumber;
    data['is_request_new_quote'] = isRequestNewQuote;
    data['quote_grade_of_noti'] = quoteGradeOfNoti;
    data['id'] = id;
    data['contact_name'] = contactName;
    data['assigned_user_name'] = assignedUserName;
    data['project_manager_name'] = projectManagerName;
    if (lineItems != null) {
      data['LineItems'] = lineItems!.map((v) => v.toJson()).toList();
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
  String? imagename;

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
        this.prodName,
        this.imagename});

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
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['productid'] = productid;
    data['sequence_no'] = sequenceNo;
    data['quantity'] = quantity;
    data['listprice'] = listprice;
    data['discount_percent'] = discountPercent;
    data['discount_amount'] = discountAmount;
    data['comment'] = comment;
    data['description'] = description;
    data['incrementondel'] = incrementondel;
    data['tax1'] = tax1;
    data['tax2'] = tax2;
    data['tax3'] = tax3;
    data['product_location'] = productLocation;
    data['product_location_title'] = productLocationTitle;
    data['costprice'] = costprice;
    data['ext_qty'] = extQty;
    data['required_document'] = requiredDocument;
    data['pro_short_description'] = proShortDescription;
    data['id'] = id;
    data['prod_name'] = prodName;
    data['imagename'] = imagename;
    return data;
  }
}