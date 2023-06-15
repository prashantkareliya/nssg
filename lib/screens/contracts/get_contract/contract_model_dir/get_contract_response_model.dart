class GetContractData {
  bool? success;
  List<Result>? result;

  GetContractData({this.success, this.result});

  GetContractData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? assignedUserId;
  String? createdtime;
  String? modifiedtime;
  String? startDate;
  String? endDate;
  String? scRelatedTo;
  String? trackingUnit;
  String? totalUnits;
  String? usedUnits;
  String? subject;
  String? dueDate;
  String? plannedDuration;
  String? actualDuration;
  String? contractStatus;
  String? contractPriority;
  String? contractType;
  String? progress;
  String? contractNo;
  String? modifiedby;
  String? quoteId;
  String? jobId;
  String? sitesaddressId;
  String? scPanel;
  String? scPanic;
  String? scJobTitle;
  String? scHealthSafety;
  String? scSystemType;
  String? scBuildStandard;
  String? scPrimarySignalType;
  String? scSecurityGrade;
  String? scGradeOfNotification;
  String? scSystemCondition;
  String? scStatus;
  String? scContractType;
  String? scPremisesType;
  String? softwareVersion;
  String? panelLocation;
  String? direction;
  String? alarmTel;
  String? lineNo;
  String? remoteAccessTel;
  String? systemId;
  String? email;
  String? telephoneNumber;
  String? mobileNumber;
  String? systemDescription;
  String? systemNotes;
  String? projectManager;
  String? scDvrNvrLocation;
  String? scRecordingEquipment;
  String? scAccessControl;
  String? scFireControlPanel;
  String? scAcuLocation;
  String? serConContractNumber;
  String? serConUrnNo1;
  String? serConUrnNo2;
  String? serConCertMiscRef;
  String? serConEngiIntruSpaci;
  String? isPoliceResponseConfirm;
  String? isInsuffiKeyholderConfirm;
  String? serConCustomerCommuni;
  String? serConHighProCustomer;
  String? serConExtendWarranty;
  String? selectCsStatus;
  String? dates;
  String? contractDate;
  String? expiresDate;
  String? closeDate;
  String? remoteSignalling;
  String? csDigiNo;
  String? centralStation;
  String? scPolice;
  String? verificationMethod;
  String? serConIssueNsiCert;
  String? csFloorPlanDocs;
  String? accountNumber;
  String? invRunCode;
  String? emailInvoice;
  String? serConMaintenance;
  String? serConMonitoring;
  String? serConKeyholding;
  String? serConInvoiSubject;
  String? serConPaymentTerm;
  String? serConAccEmailAdd;
  String? postcode;
  String? serConAddress;
  String? serConCity;
  String? serConCountry;
  String? serConInstallCompany;
  String? serConWhatThreeWord;
  String? csPictureImages;
  String? serConCompany;
  String? serConInvAddress;
  String? serConInvCity;
  String? serConInvCountry;
  String? serConInvPostcode;
  String? serInvoiceSmsSentLog;
  String? serContQuoteCorrpondDocs;
  String? contraServiInstalledDate;
  String? contraServiContractDate;
  String? contraServiExpiresDate;
  String? contraServiCloseDate;
  String? contraServiServiceMonth;
  String? contraServiPerAnnum;
  String? contraServiServiceYear;
  String? isFisrtServiceCreated;
  String? serConLossReason;
  String? serConSerBookConName;
  String? serConSerContactNumber;
  String? serConSerConEmail;
  String? serConPrivateNotes;
  String? id;
  String? assignedUserName;
  String? projectManagerName;

  Result(
      {this.assignedUserId,
        this.createdtime,
        this.modifiedtime,
        this.startDate,
        this.endDate,
        this.scRelatedTo,
        this.trackingUnit,
        this.totalUnits,
        this.usedUnits,
        this.subject,
        this.dueDate,
        this.plannedDuration,
        this.actualDuration,
        this.contractStatus,
        this.contractPriority,
        this.contractType,
        this.progress,
        this.contractNo,
        this.modifiedby,
        this.quoteId,
        this.jobId,
        this.sitesaddressId,
        this.scPanel,
        this.scPanic,
        this.scJobTitle,
        this.scHealthSafety,
        this.scSystemType,
        this.scBuildStandard,
        this.scPrimarySignalType,
        this.scSecurityGrade,
        this.scGradeOfNotification,
        this.scSystemCondition,
        this.scStatus,
        this.scContractType,
        this.scPremisesType,
        this.softwareVersion,
        this.panelLocation,
        this.direction,
        this.alarmTel,
        this.lineNo,
        this.remoteAccessTel,
        this.systemId,
        this.email,
        this.telephoneNumber,
        this.mobileNumber,
        this.systemDescription,
        this.systemNotes,
        this.projectManager,
        this.scDvrNvrLocation,
        this.scRecordingEquipment,
        this.scAccessControl,
        this.scFireControlPanel,
        this.scAcuLocation,
        this.serConContractNumber,
        this.serConUrnNo1,
        this.serConUrnNo2,
        this.serConCertMiscRef,
        this.serConEngiIntruSpaci,
        this.isPoliceResponseConfirm,
        this.isInsuffiKeyholderConfirm,
        this.serConCustomerCommuni,
        this.serConHighProCustomer,
        this.serConExtendWarranty,
        this.selectCsStatus,
        this.dates,
        this.contractDate,
        this.expiresDate,
        this.closeDate,
        this.remoteSignalling,
        this.csDigiNo,
        this.centralStation,
        this.scPolice,
        this.verificationMethod,
        this.serConIssueNsiCert,
        this.csFloorPlanDocs,
        this.accountNumber,
        this.invRunCode,
        this.emailInvoice,
        this.serConMaintenance,
        this.serConMonitoring,
        this.serConKeyholding,
        this.serConInvoiSubject,
        this.serConPaymentTerm,
        this.serConAccEmailAdd,
        this.postcode,
        this.serConAddress,
        this.serConCity,
        this.serConCountry,
        this.serConInstallCompany,
        this.serConWhatThreeWord,
        this.csPictureImages,
        this.serConCompany,
        this.serConInvAddress,
        this.serConInvCity,
        this.serConInvCountry,
        this.serConInvPostcode,
        this.serInvoiceSmsSentLog,
        this.serContQuoteCorrpondDocs,
        this.contraServiInstalledDate,
        this.contraServiContractDate,
        this.contraServiExpiresDate,
        this.contraServiCloseDate,
        this.contraServiServiceMonth,
        this.contraServiPerAnnum,
        this.contraServiServiceYear,
        this.isFisrtServiceCreated,
        this.serConLossReason,
        this.serConSerBookConName,
        this.serConSerContactNumber,
        this.serConSerConEmail,
        this.serConPrivateNotes,
        this.id,
        this.assignedUserName,
        this.projectManagerName});

  Result.fromJson(Map<String, dynamic> json) {
    assignedUserId = json['assigned_user_id'];
    createdtime = json['createdtime'];
    modifiedtime = json['modifiedtime'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    scRelatedTo = json['sc_related_to'];
    trackingUnit = json['tracking_unit'];
    totalUnits = json['total_units'];
    usedUnits = json['used_units'];
    subject = json['subject'];
    dueDate = json['due_date'];
    plannedDuration = json['planned_duration'];
    actualDuration = json['actual_duration'];
    contractStatus = json['contract_status'];
    contractPriority = json['contract_priority'];
    contractType = json['contract_type'];
    progress = json['progress'];
    contractNo = json['contract_no'];
    modifiedby = json['modifiedby'];
    quoteId = json['quote_id'];
    jobId = json['job_id'];
    sitesaddressId = json['sitesaddress_id'];
    scPanel = json['sc_panel'];
    scPanic = json['sc_panic'];
    scJobTitle = json['sc_job_title'];
    scHealthSafety = json['sc_health_safety'];
    scSystemType = json['sc_system_type'];
    scBuildStandard = json['sc_build_standard'];
    scPrimarySignalType = json['sc_primary_signal_type'];
    scSecurityGrade = json['sc_security_grade'];
    scGradeOfNotification = json['sc_grade_of_notification'];
    scSystemCondition = json['sc_system_condition'];
    scStatus = json['sc_status'];
    scContractType = json['sc_contract_type'];
    scPremisesType = json['sc_premises_type'];
    softwareVersion = json['software_version'];
    panelLocation = json['panel_location'];
    direction = json['direction'];
    alarmTel = json['alarm_tel'];
    lineNo = json['line_no'];
    remoteAccessTel = json['remote_access_tel'];
    systemId = json['system_id'];
    email = json['email'];
    telephoneNumber = json['telephone_number'];
    mobileNumber = json['mobile_number'];
    systemDescription = json['system_description'];
    systemNotes = json['system_notes'];
    projectManager = json['project_manager'];
    scDvrNvrLocation = json['sc_dvr_nvr_location'];
    scRecordingEquipment = json['sc_recording_equipment'];
    scAccessControl = json['sc_access_control'];
    scFireControlPanel = json['sc_fire_control_panel'];
    scAcuLocation = json['sc_acu_location'];
    serConContractNumber = json['ser_con_contract_number'];
    serConUrnNo1 = json['ser_con_urn_no1'];
    serConUrnNo2 = json['ser_con_urn_no2'];
    serConCertMiscRef = json['ser_con_cert_misc_ref'];
    serConEngiIntruSpaci = json['ser_con_engi_intru_spaci'];
    isPoliceResponseConfirm = json['is_police_response_confirm'];
    isInsuffiKeyholderConfirm = json['is_insuffi_keyholder_confirm'];
    serConCustomerCommuni = json['ser_con_customer_communi'];
    serConHighProCustomer = json['ser_con_high_pro_customer'];
    serConExtendWarranty = json['ser_con_extend_warranty'];
    selectCsStatus = json['select_cs_status'];
    dates = json['dates'];
    contractDate = json['contract_date'];
    expiresDate = json['expires_date'];
    closeDate = json['close_date'];
    remoteSignalling = json['remote_signalling'];
    csDigiNo = json['cs_digi_no'];
    centralStation = json['central_station'];
    scPolice = json['sc_police'];
    verificationMethod = json['verification_method'];
    serConIssueNsiCert = json['ser_con_issue_nsi_cert'];
    csFloorPlanDocs = json['cs_floor_plan_docs'];
    accountNumber = json['account_number'];
    invRunCode = json['inv_run_code'];
    emailInvoice = json['email_invoice'];
    serConMaintenance = json['ser_con_maintenance'];
    serConMonitoring = json['ser_con_monitoring'];
    serConKeyholding = json['ser_con_keyholding'];
    serConInvoiSubject = json['ser_con_invoi_subject'];
    serConPaymentTerm = json['ser_con_payment_term'];
    serConAccEmailAdd = json['ser_con_acc_email_add'];
    postcode = json['postcode'];
    serConAddress = json['ser_con_address'];
    serConCity = json['ser_con_city'];
    serConCountry = json['ser_con_country'];
    serConInstallCompany = json['ser_con_install_company'];
    serConWhatThreeWord = json['ser_con_what_three_word'];
    csPictureImages = json['cs_picture_images'];
    serConCompany = json['ser_con_company'];
    serConInvAddress = json['ser_con_inv_address'];
    serConInvCity = json['ser_con_inv_city'];
    serConInvCountry = json['ser_con_inv_country'];
    serConInvPostcode = json['ser_con_inv_postcode'];
    serInvoiceSmsSentLog = json['ser_invoice_sms_sent_log'];
    serContQuoteCorrpondDocs = json['ser_cont_quote_corrpond_docs'];
    contraServiInstalledDate = json['contra_servi_installed_date'];
    contraServiContractDate = json['contra_servi_contract_date'];
    contraServiExpiresDate = json['contra_servi_expires_date'];
    contraServiCloseDate = json['contra_servi_close_date'];
    contraServiServiceMonth = json['contra_servi_service_month'];
    contraServiPerAnnum = json['contra_servi_per_annum'];
    contraServiServiceYear = json['contra_servi_service_year'];
    isFisrtServiceCreated = json['is_fisrt_service_created'];
    serConLossReason = json['ser_con_loss_reason'];
    serConSerBookConName = json['ser_con_ser_book_con_name'];
    serConSerContactNumber = json['ser_con_ser_contact_number'];
    serConSerConEmail = json['ser_con_ser_con_email'];
    serConPrivateNotes = json['ser_con_private_notes'];
    id = json['id'];
    assignedUserName = json['assigned_user_name'];
    projectManagerName = json['project_manager_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['assigned_user_id'] = assignedUserId;
    data['createdtime'] = createdtime;
    data['modifiedtime'] = modifiedtime;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['sc_related_to'] = scRelatedTo;
    data['tracking_unit'] = trackingUnit;
    data['total_units'] = totalUnits;
    data['used_units'] = usedUnits;
    data['subject'] = subject;
    data['due_date'] = dueDate;
    data['planned_duration'] = plannedDuration;
    data['actual_duration'] = actualDuration;
    data['contract_status'] = contractStatus;
    data['contract_priority'] = contractPriority;
    data['contract_type'] = contractType;
    data['progress'] = progress;
    data['contract_no'] = contractNo;
    data['modifiedby'] = modifiedby;
    data['quote_id'] = quoteId;
    data['job_id'] = jobId;
    data['sitesaddress_id'] = sitesaddressId;
    data['sc_panel'] = scPanel;
    data['sc_panic'] = scPanic;
    data['sc_job_title'] = scJobTitle;
    data['sc_health_safety'] = scHealthSafety;
    data['sc_system_type'] = scSystemType;
    data['sc_build_standard'] = scBuildStandard;
    data['sc_primary_signal_type'] = scPrimarySignalType;
    data['sc_security_grade'] = scSecurityGrade;
    data['sc_grade_of_notification'] = scGradeOfNotification;
    data['sc_system_condition'] = scSystemCondition;
    data['sc_status'] = scStatus;
    data['sc_contract_type'] = scContractType;
    data['sc_premises_type'] = scPremisesType;
    data['software_version'] = softwareVersion;
    data['panel_location'] = panelLocation;
    data['direction'] = direction;
    data['alarm_tel'] = alarmTel;
    data['line_no'] = lineNo;
    data['remote_access_tel'] = remoteAccessTel;
    data['system_id'] = systemId;
    data['email'] = email;
    data['telephone_number'] = telephoneNumber;
    data['mobile_number'] = mobileNumber;
    data['system_description'] = systemDescription;
    data['system_notes'] = systemNotes;
    data['project_manager'] = projectManager;
    data['sc_dvr_nvr_location'] = scDvrNvrLocation;
    data['sc_recording_equipment'] = scRecordingEquipment;
    data['sc_access_control'] = scAccessControl;
    data['sc_fire_control_panel'] = scFireControlPanel;
    data['sc_acu_location'] = scAcuLocation;
    data['ser_con_contract_number'] = serConContractNumber;
    data['ser_con_urn_no1'] = serConUrnNo1;
    data['ser_con_urn_no2'] = serConUrnNo2;
    data['ser_con_cert_misc_ref'] = serConCertMiscRef;
    data['ser_con_engi_intru_spaci'] = serConEngiIntruSpaci;
    data['is_police_response_confirm'] = isPoliceResponseConfirm;
    data['is_insuffi_keyholder_confirm'] = isInsuffiKeyholderConfirm;
    data['ser_con_customer_communi'] = serConCustomerCommuni;
    data['ser_con_high_pro_customer'] = serConHighProCustomer;
    data['ser_con_extend_warranty'] = serConExtendWarranty;
    data['select_cs_status'] = selectCsStatus;
    data['dates'] = dates;
    data['contract_date'] = contractDate;
    data['expires_date'] = expiresDate;
    data['close_date'] = closeDate;
    data['remote_signalling'] = remoteSignalling;
    data['cs_digi_no'] = csDigiNo;
    data['central_station'] = centralStation;
    data['sc_police'] = scPolice;
    data['verification_method'] = verificationMethod;
    data['ser_con_issue_nsi_cert'] = serConIssueNsiCert;
    data['cs_floor_plan_docs'] = csFloorPlanDocs;
    data['account_number'] = accountNumber;
    data['inv_run_code'] = invRunCode;
    data['email_invoice'] = emailInvoice;
    data['ser_con_maintenance'] = serConMaintenance;
    data['ser_con_monitoring'] = serConMonitoring;
    data['ser_con_keyholding'] = serConKeyholding;
    data['ser_con_invoi_subject'] = serConInvoiSubject;
    data['ser_con_payment_term'] = serConPaymentTerm;
    data['ser_con_acc_email_add'] = serConAccEmailAdd;
    data['postcode'] = postcode;
    data['ser_con_address'] = serConAddress;
    data['ser_con_city'] = serConCity;
    data['ser_con_country'] = serConCountry;
    data['ser_con_install_company'] = serConInstallCompany;
    data['ser_con_what_three_word'] = serConWhatThreeWord;
    data['cs_picture_images'] = csPictureImages;
    data['ser_con_company'] = serConCompany;
    data['ser_con_inv_address'] = serConInvAddress;
    data['ser_con_inv_city'] = serConInvCity;
    data['ser_con_inv_country'] = serConInvCountry;
    data['ser_con_inv_postcode'] = serConInvPostcode;
    data['ser_invoice_sms_sent_log'] = serInvoiceSmsSentLog;
    data['ser_cont_quote_corrpond_docs'] = serContQuoteCorrpondDocs;
    data['contra_servi_installed_date'] = contraServiInstalledDate;
    data['contra_servi_contract_date'] = contraServiContractDate;
    data['contra_servi_expires_date'] = contraServiExpiresDate;
    data['contra_servi_close_date'] = contraServiCloseDate;
    data['contra_servi_service_month'] = contraServiServiceMonth;
    data['contra_servi_per_annum'] = contraServiPerAnnum;
    data['contra_servi_service_year'] = contraServiServiceYear;
    data['is_fisrt_service_created'] = isFisrtServiceCreated;
    data['ser_con_loss_reason'] = serConLossReason;
    data['ser_con_ser_book_con_name'] = serConSerBookConName;
    data['ser_con_ser_contact_number'] = serConSerContactNumber;
    data['ser_con_ser_con_email'] = serConSerConEmail;
    data['ser_con_private_notes'] = serConPrivateNotes;
    data['id'] = id;
    data['assigned_user_name'] = assignedUserName;
    data['project_manager_name'] = projectManagerName;
    return data;
  }
}