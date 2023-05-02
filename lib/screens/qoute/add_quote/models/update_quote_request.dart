class UpdateQuoteRequest {
  String? subject;
  String? quotestage;
  String? contactId;
  String? subtotal;
  String? txtAdjustment;
  String? hdnGrandTotal;
  String? hdnTaxType;
  String? hdnDiscountPercent;
  String? hdnDiscountAmount;
  String? hdnSHAmount;
  String? assignedUserId;
  String? currencyId;
  String? conversionRate;
  String? billStreet;
  String? shipStreet;
  String? billCity;
  String? shipCity;
  String? billCountry;
  String? shipCountry;
  String? billCode;
  String? shipCode;
  String? description;
  String? termsConditions;
  String? preTaxTotal;
  String? hdnSHPercent;
  String? siteAddressId;
  String? quotesTerms;
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
  String? floorPlanDocs;
  String? quotesCompany;
  String? installation;
  String? hdnsubTotal;
  String? hdndiscountTotal;
  String? quoteMobileNumber;
  String? quoteTelephoneNumber;
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
  String? quotePoNumber;
  String? quoteGradeOfNoti;
  List<LineItemsUpdate>? lineItemsUpdate;

  UpdateQuoteRequest(
      {this.subject,
        this.quotestage,
        this.contactId,
        this.subtotal,
        this.txtAdjustment,
        this.hdnGrandTotal,
        this.hdnTaxType,
        this.hdnDiscountPercent,
        this.hdnDiscountAmount,
        this.hdnSHAmount,
        this.assignedUserId,
        this.currencyId,
        this.conversionRate,
        this.billStreet,
        this.shipStreet,
        this.billCity,
        this.shipCity,
        this.billCountry,
        this.shipCountry,
        this.billCode,
        this.shipCode,
        this.description,
        this.termsConditions,
        this.preTaxTotal,
        this.hdnSHPercent,
        this.siteAddressId,
        this.quotesTerms,
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
        this.floorPlanDocs,
        this.quotesCompany,
        this.installation,
        this.hdnsubTotal,
        this.hdndiscountTotal,
        this.quoteMobileNumber,
        this.quoteTelephoneNumber,
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
        this.quotePoNumber,
        this.quoteGradeOfNoti,
        this.lineItemsUpdate});

  UpdateQuoteRequest.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    quotestage = json['quotestage'];
    contactId = json['contact_id'];
    subtotal = json['subtotal'];
    txtAdjustment = json['txtAdjustment'];
    hdnGrandTotal = json['hdnGrandTotal'];
    hdnTaxType = json['hdnTaxType'];
    hdnDiscountPercent = json['hdnDiscountPercent'];
    hdnDiscountAmount = json['hdnDiscountAmount'];
    hdnSHAmount = json['hdnS_H_Amount'];
    assignedUserId = json['assigned_user_id'];
    currencyId = json['currency_id'];
    conversionRate = json['conversion_rate'];
    billStreet = json['bill_street'];
    shipStreet = json['ship_street'];
    billCity = json['bill_city'];
    shipCity = json['ship_city'];
    billCountry = json['bill_country'];
    shipCountry = json['ship_country'];
    billCode = json['bill_code'];
    shipCode = json['ship_code'];
    description = json['description'];
    termsConditions = json['terms_conditions'];
    preTaxTotal = json['pre_tax_total'];
    hdnSHPercent = json['hdnS_H_Percent'];
    siteAddressId = json['site_address_id'];
    quotesTerms = json['quotes_terms'];
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
    floorPlanDocs = json['floor_plan_docs'];
    quotesCompany = json['quotes_company'];
    installation = json['installation'];
    hdnsubTotal = json['hdnsubTotal'];
    hdndiscountTotal = json['hdndiscountTotal'];
    quoteMobileNumber = json['quote_mobile_number'];
    quoteTelephoneNumber = json['quote_telephone_number'];
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
    quoteGradeOfNoti = json['quote_grade_of_noti'];
    id = json['id'];
    if (json['LineItems'] != null) {
      lineItemsUpdate = <LineItemsUpdate>[];
      json['LineItems'].forEach((v) {
        lineItemsUpdate!.add(new LineItemsUpdate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = subject;
    data['quotestage'] = quotestage;
    data['contact_id'] = contactId;
    data['subtotal'] = subtotal;
    data['txtAdjustment'] = txtAdjustment;
    data['hdnGrandTotal'] = hdnGrandTotal;
    data['hdnTaxType'] = hdnTaxType;
    data['hdnDiscountPercent'] = hdnDiscountPercent;
    data['hdnDiscountAmount'] = hdnDiscountAmount;
    data['hdnS_H_Amount'] = hdnSHAmount;
    data['assigned_user_id'] = assignedUserId;
    data['currency_id'] = currencyId;
    data['conversion_rate'] = conversionRate;
    data['bill_street'] = billStreet;
    data['ship_street'] = shipStreet;
    data['bill_city'] = billCity;
    data['ship_city'] = shipCity;
    data['bill_country'] = billCountry;
    data['ship_country'] = shipCountry;
    data['bill_code'] = billCode;
    data['ship_code'] = shipCode;
    data['description'] = description;
    data['terms_conditions'] = termsConditions;
    data['pre_tax_total'] = preTaxTotal;
    data['hdnS_H_Percent'] = hdnSHPercent;
    data['site_address_id'] = siteAddressId;
    data['quotes_terms'] = quotesTerms;
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
    data['floor_plan_docs'] = floorPlanDocs;
    data['quotes_company'] = quotesCompany;
    data['installation'] = installation;
    data['hdnsubTotal'] = hdnsubTotal;
    data['hdndiscountTotal'] = hdndiscountTotal;
    data['quote_mobile_number'] = quoteMobileNumber;
    data['quote_telephone_number'] = quoteTelephoneNumber;
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
    data['quote_grade_of_noti'] = quoteGradeOfNoti;
    data['id'] = id;
    if (lineItemsUpdate != null) {
      data['LineItems'] = lineItemsUpdate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItemsUpdate {
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
  String? proName;
  String? profit;

  LineItemsUpdate(
      {this.productid,
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
        this.proName,this.profit});

  LineItemsUpdate.fromJson(Map<String, dynamic> json) {
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
    proName = json["prod_name"];
    profit = json["profit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['prod_name'] = proName;
    data['profit'] = profit;
    return data;
  }
}