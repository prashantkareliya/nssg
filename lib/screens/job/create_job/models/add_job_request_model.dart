class CreateJobRequest {
  String? subject;
  String? quoteId;
  String? contactId;
  String? sostatus;
  String? hdnGrandTotal;
  String? hdnSubTotal;
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
  String? startPeriod;
  String? endPeriod;
  String? paymentDuration;
  String? invoicestatus;
  String? preTaxTotal;
  String? hdnSHPercent;
  String? jobCompany;
  String? contractNumber;
  String? jobsSystemType;
  String? jobsTerms;
  String? jobsGradeNumber;
  String? jobsSignallingType;
  String? jobsProjectManager;
  String? installation;
  String? email;
  String? telephoneNumber;
  String? mobileNumber;
  String? priorityLevel;
  String? engineersNote;
  String? officeNote;
  String? specialInstructions;
  String? installationTimeRequired;
  String? preferredInstallationTeam;
  String? worksSchedule;
  String? instructionsToProceed;
  String? paymentInstructions;
  String? paymentMethod;
  String? isConfirm;
  String? contractNotesJob;
  String? invoiceNumber;
  String? jobPremisesType;
  String? jobTaskTimestamp;
  String? hdnprofitTotal;
  String? jobType;
  String? soJobStatus;
  String? isscheduledjob;
  String? isJobScheduleMailSent;
  String? jobServiServiceMonth;
  String? jobServiPerAnnum;
  String? jobServiServiceYear;
  String? jobServiServiceType;
  String? salesorderRelatedId;
  String? isCustomerConfirm;
  String? jobSchDateByCustomer;
  String? jobSchAltDateByCustomer;
  String? jobSchCustomerNotes;
  String? isProjectTaskCreatedAsana;
  String? asanaCreatedProjectId;
  String? jobPartStatus;
  String? jotformWorkCarryOut;
  String? jotformOutStandWork;
  String? jotformPartReqNextVisit;
  String? jotformAddWorkToQuote;
  String? jotformPartUsed;
  String? jobChecklistBooked;
  String? jobChecklistRaiseInvoice;
  String? jobChecklistRaiseInvoiceNumber;
  String? jobChecklistPickListStock;
  String? jobChecklistObtCustFeedback;
  String? jobChecklistPaymentOnComplet;
  String? jobChecklistExtraStockAllocate;
  String? jobChecklistExtraStockReturnFaulty;
  String? jobChecklistCommsAllocated;
  String? jobChecklistCreateContract;
  String? jobChecklistOrderComms;
  String? jobChecklistUrnSentClient;
  String? jobChecklistUrnReceivedClient;
  String? jobChecklistUrnAppliPoliceForce;
  String? jobChecklistUrnReceivedPoliceForce;
  String? jobChecklistMaintenSentClient;
  String? jobChecklistMaintenReceived;
  String? jobChecklistKeyholderSentClient;
  String? jobChecklistKeyholderReceived;
  String? jobChecklistCsDigiCheck;
  String? jobChecklistCsDigiNumber;
  String? jobChecklistIssueNsiCertCheck;
  String? jobChecklistIssueNsiCertNumber;
  String? jobChecklistReadyToClose;
  String?  jobChecklistStockRequire  ;
  String? jobChecklistPayRecived;
  String? jobChecklistDdRecSubSetup;
  List<dynamic>? lineItems;

  CreateJobRequest(
      {this.subject,
        this.quoteId,
        this.contactId,
        this.sostatus,
        this.hdnGrandTotal,
        this.hdnSubTotal,
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
        this.startPeriod,
        this.endPeriod,
        this.paymentDuration,
        this.invoicestatus,
        this.preTaxTotal,
        this.hdnSHPercent,
        this.jobCompany,
        this.contractNumber,
        this.jobsSystemType,
        this.jobsTerms,
        this.jobsGradeNumber,
        this.jobsSignallingType,
        this.jobsProjectManager,
        this.installation,
        this.email,
        this.telephoneNumber,
        this.mobileNumber,
        this.priorityLevel,
        this.engineersNote,
        this.officeNote,
        this.specialInstructions,
        this.installationTimeRequired,
        this.preferredInstallationTeam,
        this.worksSchedule,
        this.instructionsToProceed,
        this.paymentInstructions,
        this.paymentMethod,
        this.isConfirm,
        this.contractNotesJob,
        this.invoiceNumber,
        this.jobPremisesType,
        this.jobTaskTimestamp,
        this.hdnprofitTotal,
        this.jobType,
        this.soJobStatus,
        this.isscheduledjob,
        this.isJobScheduleMailSent,
        this.jobServiServiceMonth,
        this.jobServiPerAnnum,
        this.jobServiServiceYear,
        this.jobServiServiceType,
        this.salesorderRelatedId,
        this.isCustomerConfirm,
        this.jobSchDateByCustomer,
        this.jobSchAltDateByCustomer,
        this.jobSchCustomerNotes,
        this.isProjectTaskCreatedAsana,
        this.asanaCreatedProjectId,
        this.jobPartStatus,
        this.jotformWorkCarryOut,
        this.jotformOutStandWork,
        this.jotformPartReqNextVisit,
        this.jotformAddWorkToQuote,
        this.jotformPartUsed,
        this.jobChecklistBooked,
        this.jobChecklistRaiseInvoice,
        this.jobChecklistRaiseInvoiceNumber,
        this.jobChecklistPickListStock,
        this.jobChecklistObtCustFeedback,
        this.jobChecklistPaymentOnComplet,
        this.jobChecklistExtraStockAllocate,
        this.jobChecklistExtraStockReturnFaulty,
        this.jobChecklistCommsAllocated,
        this.jobChecklistCreateContract,
        this.jobChecklistOrderComms,
        this.jobChecklistUrnSentClient,
        this.jobChecklistUrnReceivedClient,
        this.jobChecklistUrnAppliPoliceForce,
        this.jobChecklistUrnReceivedPoliceForce,
        this.jobChecklistMaintenSentClient,
        this.jobChecklistMaintenReceived,
        this.jobChecklistKeyholderSentClient,
        this.jobChecklistKeyholderReceived,
        this.jobChecklistCsDigiCheck,
        this.jobChecklistCsDigiNumber,
        this.jobChecklistIssueNsiCertCheck,
        this.jobChecklistIssueNsiCertNumber,
        this.jobChecklistReadyToClose,
        this.jobChecklistStockRequire,
        this.jobChecklistPayRecived,
        this.jobChecklistDdRecSubSetup,
        this.lineItems});

  CreateJobRequest.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    quoteId = json['quote_id'];
    contactId = json['contact_id'];
    sostatus = json['sostatus'];
    hdnGrandTotal = json['hdnGrandTotal'];
    hdnSubTotal = json['hdnSubTotal'];
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
    startPeriod = json['start_period'];
    endPeriod = json['end_period'];
    paymentDuration = json['payment_duration'];
    invoicestatus = json['invoicestatus'];
    preTaxTotal = json['pre_tax_total'];
    hdnSHPercent = json['hdnS_H_Percent'];
    jobCompany = json['job_company'];
    contractNumber = json['contract_number'];
    jobsSystemType = json['jobs_system_type'];
    jobsTerms = json['jobs_terms'];
    jobsGradeNumber = json['jobs_grade_number'];
    jobsSignallingType = json['jobs_signalling_type'];
    jobsProjectManager = json['jobs_project_manager'];
    installation = json['installation'];
    email = json['email'];
    telephoneNumber = json['telephone_number'];
    mobileNumber = json['mobile_number'];
    priorityLevel = json['priority_level'];
    engineersNote = json['engineers_note'];
    officeNote = json['office_note'];
    specialInstructions = json['special_instructions'];
    installationTimeRequired = json['installation_time_required'];
    preferredInstallationTeam = json['preferred_installation_team'];
    worksSchedule = json['works_schedule'];
    instructionsToProceed = json['instructions_to_proceed'];
    paymentInstructions = json['payment_instructions'];
    paymentMethod = json['payment_method'];
    isConfirm = json['is_confirm'];
    contractNotesJob = json['contract_notes_job'];
    invoiceNumber = json['invoice_number'];
    jobPremisesType = json['job_premises_type'];
    jobTaskTimestamp = json['job_task_timestamp'];
    hdnprofitTotal = json['hdnprofitTotal'];
    jobType = json['job_type'];
    soJobStatus = json['so_job_status'];
    isscheduledjob = json['isscheduledjob'];
    isJobScheduleMailSent = json['is_job_schedule_mail_sent'];
    jobServiServiceMonth = json['job_servi_service_month'];
    jobServiPerAnnum = json['job_servi_per_annum'];
    jobServiServiceYear = json['job_servi_service_year'];
    jobServiServiceType = json['job_servi_service_type'];
    salesorderRelatedId = json['salesorder_related_id'];
    isCustomerConfirm = json['is_customer_confirm'];
    jobSchDateByCustomer = json['job_sch_date_by_customer'];
    jobSchAltDateByCustomer = json['job_sch_alt_date_by_customer'];
    jobSchCustomerNotes = json['job_sch_customer_notes'];
    isProjectTaskCreatedAsana = json['is_project_task_created_asana'];
    asanaCreatedProjectId = json['asana_created_project_id'];
    jobPartStatus = json['job_part_status'];
    jotformWorkCarryOut = json['jotform_work_carry_out'];
    jotformOutStandWork = json['jotform_out_stand_work'];
    jotformPartReqNextVisit = json['jotform_part_req_next_visit'];
    jotformAddWorkToQuote = json['jotform_add_work_to_quote'];
    jotformPartUsed = json['jotform_part_used'];
    jobChecklistBooked = json['job_checklist_booked'];
    jobChecklistRaiseInvoice = json['job_checklist_raise_invoice'];
    jobChecklistRaiseInvoiceNumber = json['job_checklist_raise_invoice_number'];
    jobChecklistPickListStock = json['job_checklist_pick_list_stock'];
    jobChecklistObtCustFeedback = json['job_checklist_obt_cust_feedback'];
    jobChecklistPaymentOnComplet = json['job_checklist_payment_on_complet'];
    jobChecklistExtraStockAllocate = json['job_checklist_extra_stock_allocate'];
    jobChecklistExtraStockReturnFaulty =
    json['job_checklist_extra_stock_return_faulty'];
    jobChecklistCommsAllocated = json['job_checklist_comms_allocated'];
    jobChecklistCreateContract = json['job_checklist_create_contract'];
    jobChecklistOrderComms = json['job_checklist_order_comms'];
    jobChecklistUrnSentClient = json['job_checklist_urn_sent_client'];
    jobChecklistUrnReceivedClient = json['job_checklist_urn_received_client'];
    jobChecklistUrnAppliPoliceForce =
    json['job_checklist_urn_appli_police_force'];
    jobChecklistUrnReceivedPoliceForce =
    json['job_checklist_urn_received_police_force'];
    jobChecklistMaintenSentClient = json['job_checklist_mainten_sent_client'];
    jobChecklistMaintenReceived = json['job_checklist_mainten_received'];
    jobChecklistKeyholderSentClient =
    json['job_checklist_keyholder_sent_client'];
    jobChecklistKeyholderReceived = json['job_checklist_keyholder_received'];
    jobChecklistCsDigiCheck = json['job_checklist_cs_digi_check'];
    jobChecklistCsDigiNumber = json['job_checklist_cs_digi_number'];
    jobChecklistIssueNsiCertCheck = json['job_checklist_issue_nsi_cert_check'];
    jobChecklistIssueNsiCertNumber =
    json['job_checklist_issue_nsi_cert_number'];
    jobChecklistReadyToClose = json['job_checklist_ready_to_close'];
    jobChecklistStockRequire = json['job_checklist_stock_require'];
    jobChecklistPayRecived = json['job_checklist_pay_recived'];
    jobChecklistDdRecSubSetup = json['job_checklist_dd_rec_sub_setup'];
    if (json['LineItems'] != null) {
      lineItems = <LineItems>[];
      json['LineItems'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['quote_id'] = quoteId;
    data['contact_id'] = contactId;
    data['sostatus'] = sostatus;
    data['hdnGrandTotal'] = hdnGrandTotal;
    data['hdnSubTotal'] = hdnSubTotal;
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
    data['start_period'] = startPeriod;
    data['end_period'] = endPeriod;
    data['payment_duration'] = paymentDuration;
    data['invoicestatus'] = invoicestatus;
    data['pre_tax_total'] = preTaxTotal;
    data['hdnS_H_Percent'] = hdnSHPercent;
    data['job_company'] = jobCompany;
    data['contract_number'] = contractNumber;
    data['jobs_system_type'] = jobsSystemType;
    data['jobs_terms'] = jobsTerms;
    data['jobs_grade_number'] = jobsGradeNumber;
    data['jobs_signalling_type'] = jobsSignallingType;
    data['jobs_project_manager'] = jobsProjectManager;
    data['installation'] = installation;
    data['email'] = email;
    data['telephone_number'] = telephoneNumber;
    data['mobile_number'] = mobileNumber;
    data['priority_level'] = priorityLevel;
    data['engineers_note'] = engineersNote;
    data['office_note'] = officeNote;
    data['special_instructions'] = specialInstructions;
    data['installation_time_required'] = installationTimeRequired;
    data['preferred_installation_team'] = preferredInstallationTeam;
    data['works_schedule'] = worksSchedule;
    data['instructions_to_proceed'] = instructionsToProceed;
    data['payment_instructions'] = paymentInstructions;
    data['payment_method'] = paymentMethod;
    data['is_confirm'] = isConfirm;
    data['contract_notes_job'] = contractNotesJob;
    data['invoice_number'] = invoiceNumber;
    data['job_premises_type'] = jobPremisesType;
    data['job_task_timestamp'] = jobTaskTimestamp;
    data['hdnprofitTotal'] = hdnprofitTotal;
    data['job_type'] = jobType;
    data['so_job_status'] = soJobStatus;
    data['isscheduledjob'] = isscheduledjob;
    data['is_job_schedule_mail_sent'] = isJobScheduleMailSent;
    data['job_servi_service_month'] = jobServiServiceMonth;
    data['job_servi_per_annum'] = jobServiPerAnnum;
    data['job_servi_service_year'] = jobServiServiceYear;
    data['job_servi_service_type'] = jobServiServiceType;
    data['salesorder_related_id'] = salesorderRelatedId;
    data['is_customer_confirm'] = isCustomerConfirm;
    data['job_sch_date_by_customer'] = jobSchDateByCustomer;
    data['job_sch_alt_date_by_customer'] = jobSchAltDateByCustomer;
    data['job_sch_customer_notes'] = jobSchCustomerNotes;
    data['is_project_task_created_asana'] = isProjectTaskCreatedAsana;
    data['asana_created_project_id'] = asanaCreatedProjectId;
    data['job_part_status'] = jobPartStatus;
    data['jotform_work_carry_out'] = jotformWorkCarryOut;
    data['jotform_out_stand_work'] = jotformOutStandWork;
    data['jotform_part_req_next_visit'] = jotformPartReqNextVisit;
    data['jotform_add_work_to_quote'] = jotformAddWorkToQuote;
    data['jotform_part_used'] = jotformPartUsed;
    data['job_checklist_booked'] = jobChecklistBooked;
    data['job_checklist_raise_invoice'] = jobChecklistRaiseInvoice;
    data['job_checklist_raise_invoice_number'] =
        jobChecklistRaiseInvoiceNumber;
    data['job_checklist_pick_list_stock'] = jobChecklistPickListStock;
    data['job_checklist_obt_cust_feedback'] = jobChecklistObtCustFeedback;
    data['job_checklist_payment_on_complet'] =
        jobChecklistPaymentOnComplet;
    data['job_checklist_extra_stock_allocate'] =
        jobChecklistExtraStockAllocate;
    data['job_checklist_extra_stock_return_faulty'] =
        jobChecklistExtraStockReturnFaulty;
    data['job_checklist_comms_allocated'] = jobChecklistCommsAllocated;
    data['job_checklist_create_contract'] = jobChecklistCreateContract;
    data['job_checklist_order_comms'] = jobChecklistOrderComms;
    data['job_checklist_urn_sent_client'] = jobChecklistUrnSentClient;
    data['job_checklist_urn_received_client'] =
        jobChecklistUrnReceivedClient;
    data['job_checklist_urn_appli_police_force'] =
        jobChecklistUrnAppliPoliceForce;
    data['job_checklist_urn_received_police_force'] =
        jobChecklistUrnReceivedPoliceForce;
    data['job_checklist_mainten_sent_client'] =
        jobChecklistMaintenSentClient;
    data['job_checklist_mainten_received'] = jobChecklistMaintenReceived;
    data['job_checklist_keyholder_sent_client'] =
        jobChecklistKeyholderSentClient;
    data['job_checklist_keyholder_received'] =
        jobChecklistKeyholderReceived;
    data['job_checklist_cs_digi_check'] = jobChecklistCsDigiCheck;
    data['job_checklist_cs_digi_number'] = jobChecklistCsDigiNumber;
    data['job_checklist_issue_nsi_cert_check'] =
        jobChecklistIssueNsiCertCheck;
    data['job_checklist_issue_nsi_cert_number'] =
        jobChecklistIssueNsiCertNumber;
    data['job_checklist_ready_to_close'] = jobChecklistReadyToClose;
    data['job_checklist_stock_require'] = jobChecklistStockRequire;
    data['job_checklist_pay_recived'] = jobChecklistPayRecived;
    data['job_checklist_dd_rec_sub_setup'] = jobChecklistDdRecSubSetup;
    if (lineItems != null) {
      data['LineItems'] = lineItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineItems {
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

  LineItems(
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
        this.proShortDescription});

  LineItems.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}