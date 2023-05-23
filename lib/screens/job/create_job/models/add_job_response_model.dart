class CreateJobResponse {
  bool? success;
  Result? result;

  CreateJobResponse({this.success, this.result});

  CreateJobResponse.fromJson(Map<String, dynamic> json) {
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
  String? salesorderNo;
  String? subject;
  String? potentialId;
  String? customerno;
  String? quoteId;
  String? vtigerPurchaseorder;
  String? contactId;
  String? duedate;
  String? carrier;
  String? pending;
  String? sostatus;
  String? txtAdjustment;
  String? salescommission;
  String? exciseduty;
  String? hdnGrandTotal;
  String? hdnSubTotal;
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
  String? enableRecurring;
  String? recurringFrequency;
  String? startPeriod;
  String? endPeriod;
  String? paymentDuration;
  String? invoicestatus;
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
  String? extQty;
  String? checkStockAvailability;
  String? createJobsheet;
  String? allocateEngineers;
  String? confirmAppointment;
  String? dispatchJobsheet;
  String? collectDepositPayment;
  String? raiseInvoice;
  String? orderStockRequired;
  String? allocateStockUponReceipt;
  String? pickOutStockJob;
  String? bookWorkClient;
  String? requestInstruction;
  String? rebbokRevisits;
  String? callUpdateNotes;
  String? completionCheckWork;
  String? customerFeedback;
  String? notesPaymentCompletion;
  String? paymentCollectedEngineer;
  String? sendInvoiceCompletion;
  String? passStockToEngineer;
  String? passCommsToEngineer;
  String? arrangeAddition;
  String? stockForRevisit;
  String? pickStockForRevisit;
  String? collectStockFromEngineer;
  String? setupTestRemoteAccess;
  String? createContract;
  String? orderComms;
  String? applyUrn;
  String? sendEngineerDocument;
  String? maintenanceAgreement;
  String? jobProgress;
  String? jobCompany;
  String? floorPlanDocsJob;
  String? contractNumber;
  String? jobSystemType;
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
  String? flaggedDate;
  String? flaggedNotes;
  String? closeJob;
  String? maintenanceSentClient;
  String? maintenanceReceivedClient;
  String? keyholdersSentClient;
  String? keyholdersReceivedClient;
  String? urnSentClient;
  String? urnReceivedClient;
  String? urnAppliedPoliceForce;
  String? urnReceivedPoliceForce;
  String? jobExtraStockReturnFaulty;
  String? jobPaymentToCollect;
  String? completedTechnicalNotes;
  String? jobTaskTimestamp;
  String? hdnprofitTotal;
  String? jobListingNotes;
  String? jobNotesUserId;
  String? jobType;
  String? soJobStatus;
  String? scheduleDateStart;
  String? scheduleTimeStart;
  String? scheduleTimeEnd;
  String? scheduleEngineerNotes;
  String? scheduleRevisitDescription;
  String? isscheduledjob;
  String? breWorksCompleted;
  String? breRevisitRequired;
  String? brePartsRequired;
  String? breAnyPartsUsed;
  String? brePaymentCollected;
  String? breSystemLeftWork;
  String? breCheTimeDate;
  String? breCsDigiNo;
  String? breInstalled;
  String? breRemSignal;
  String? breLastVisit;
  String? brePolice;
  String? breArriTime;
  String? breDeparTime;
  String? brePartsMakeModel;
  String? brePartsMakeModelQty;
  String? breDisablePartOfSys;
  String? breOnsiteTime;
  String? breArivalToDepart;
  String? serFusedCorrFitt;
  String? serFusedCorrFittNotes;
  String? serBattFreeCorr;
  String? serBattFreeCorrNotes;
  String? serBattUnderYear;
  String? serBattUnderYearNotes;
  String? serBattChargVolt;
  String? serBattChargVoltValue;
  String? serBattPassLoad;
  String? serBattPassLoadRepl;
  String? serBattPassreplApprov;
  String? serBattTakeover;
  String? serBattChargRateVal;
  String? serBattChargRateNotes;
  String? serBattVoltMinVal;
  String? serBattVoltMinNotes;
  String? serCommsFaultPanel;
  String? serCommsFaultPanelNotes;
  String? serChanSignalToArc;
  String? serChanSignalToArcNotes;
  String? serSignalRecByArc;
  String? serSignalRecByArcNotes;
  String? serCheFreeTempFal;
  String? serCheFreeTempFalNotes;
  String? serCheZoneDisable;
  String? serCheZoneDisableReason;
  String? serCheZoneDisNotifi;
  String? serCheZoneDisActReq;
  String? serTimeDateCorr;
  String? serTimeDateCorrNotes;
  String? serLeftWorkOrder;
  String? serLeftWorkOrderNotes;
  String? serPartWorkReaList;
  String? serReasPartWorking;
  String? serReasPartWorkNotifi;
  String? serReasPartWorkActReq;
  String? breCustomerSignName;
  String? breCustomerSign;
  String? breCustomerSignDate;
  String? breEngineerSignName;
  String? breEngineerSign;
  String? breEngineerSignDate;
  String? jobCsDigiCheck;
  String? jobCsDigiNumber;
  String? serCctvCameraViCheck;
  String? serCctvCameraViCheckNotes;
  String? serCctvCameraInFocus;
  String? serCctvCameraInFocusNotes;
  String? serCctvCameraQuaAtNight;
  String? serCctvCameraQuaAtNightNotes;
  String? serCctvPlaybackReco;
  String? serCctvNoOfDayStorage;
  String? serCctvDvrNvrCond;
  String? serCctvDvrNvrCondNotes;
  String? serCctvMoniScrCond;
  String? serCctvMoniScrCondNotes;
  String? serCctvSysDocAvilSite;
  String? serCctvReqDocument;
  String? serCctvSysCondi;
  String? serCctvDvrNvrTimeDate;
  String? jobIssueNsiCert;
  String? jobIssueNsiCertNumber;
  String? jobIntZoneNumber;
  String? jobIntZoneNodeNumber;
  String? jobIntZoneLocations;
  String? jobIntZoneDeviceType;
  String? jobIntZoneType;
  String? jobIntZoneWalkTested;
  String? jobIntZonePassed;
  String? jobIntBattPowerSupplyNo;
  String? jobIntBattPsuLocation;
  String? jobIntBattBatteryAmps;
  String? jobIntBattBatteryVoltage;
  String? jobIntBattPsuVoltage;
  String? jobIntBattBatteryLab;
  String? jobIntBattBatteryPassed;
  String? jobIntBattPsuPassed;
  String? jobIntruSounderNumber;
  String? jobIntruSounderLocations;
  String? jobIntruSounderTested;
  String? jobIntruHoldupTested;
  String? jobIntruStrobeTest;
  String? jobIntruControlPanelMake;
  String? jobIntruControlPanelLocations;
  String? jobIntruPanelBattCurrent;
  String? jobIntruPanelPsuBattCurr;
  String? jobIntruPanelKeypadNo;
  String? jobIntruPanelKeypadLocat;
  String? jobIntruPanelRestUponEntry;
  String? jobIntruPanelFused;
  String? jobIntruPanelPsuFused;
  String? jobIntruTimersBellDelay;
  String? jobIntruTimersBellDuration;
  String? jobIntruTimersEntryTime;
  String? jobIntruTimersExitTime;
  String? jobIntruCommsconnLineNo;
  String? jobIntruCommsconnRemAccess;
  String? jobIntruCommsconnSystemid;
  String? jobIntruCommsconnSoftVer;
  String? jobIntEngScPanel;
  String? jobIntEngAlarmTel;
  String? jobIntEngScPanic;
  String? jobIntEngHealthSafety;
  String? jobIntEngSystemCondition;
  String? jobIntEngBuildStandard;
  String? jobIntEngSignalingChanel;
  String? engJobNotes;
  String? jobSchBookedBy;
  String? jobIntruSoftVer;
  String? jobIntruPanelType;
  String? jobIntruInstalledDate;
  String? jobIntruSignalType;
  String? jobIntruIpAddress;
  String? jobIntruChip;
  String? jobIntruSysTestArc;
  String? jobIntruArc;
  String? jobIntruInfCusAlarmTest;
  String? jobRejectedNotes;
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
  String? isJobScheduleMailSent;
  String? jobQrcodePreview;
  String? jobSmsSentLog;
  String? jobChecklistStockRequire;
  String? jobChecklistPayRecived;
  String? jobChecklistDdRecSubSetup;
  String? jobServiServiceMonth;
  String? jobServiPerAnnum;
  String? jobServiServiceYear;
  String? jobServiServiceType;
  String? salesorderRelatedId;
  String? isCustomerConfirm;
  String? jobSchDateByCustomer;
  String? jobSchAltDateByCustomer;
  String? jobSchCustomerNotes;
  String? jobWhatThreeWord;
  String? isProjectTaskCreatedAsana;
  String? asanaCreatedProjectId;
  String? jobPartStatus;
  String? jotformWorkCarryOut;
  String? jotformOutStandWork;
  String? jotformPartReqNextVisit;
  String? jotformAddWorkToQuote;
  String? jotformPartUsed;
  String? id;
  String? contactName;
  String? assignedUserName;
  List<LineItems>? lineItems;

  Result(
      {this.salesorderNo,
        this.subject,
        this.potentialId,
        this.customerno,
        this.quoteId,
        this.vtigerPurchaseorder,
        this.contactId,
        this.duedate,
        this.carrier,
        this.pending,
        this.sostatus,
        this.txtAdjustment,
        this.salescommission,
        this.exciseduty,
        this.hdnGrandTotal,
        this.hdnSubTotal,
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
        this.enableRecurring,
        this.recurringFrequency,
        this.startPeriod,
        this.endPeriod,
        this.paymentDuration,
        this.invoicestatus,
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
        this.extQty,
        this.checkStockAvailability,
        this.createJobsheet,
        this.allocateEngineers,
        this.confirmAppointment,
        this.dispatchJobsheet,
        this.collectDepositPayment,
        this.raiseInvoice,
        this.orderStockRequired,
        this.allocateStockUponReceipt,
        this.pickOutStockJob,
        this.bookWorkClient,
        this.requestInstruction,
        this.rebbokRevisits,
        this.callUpdateNotes,
        this.completionCheckWork,
        this.customerFeedback,
        this.notesPaymentCompletion,
        this.paymentCollectedEngineer,
        this.sendInvoiceCompletion,
        this.passStockToEngineer,
        this.passCommsToEngineer,
        this.arrangeAddition,
        this.stockForRevisit,
        this.pickStockForRevisit,
        this.collectStockFromEngineer,
        this.setupTestRemoteAccess,
        this.createContract,
        this.orderComms,
        this.applyUrn,
        this.sendEngineerDocument,
        this.maintenanceAgreement,
        this.jobProgress,
        this.jobCompany,
        this.floorPlanDocsJob,
        this.contractNumber,
        this.jobSystemType,
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
        this.flaggedDate,
        this.flaggedNotes,
        this.closeJob,
        this.maintenanceSentClient,
        this.maintenanceReceivedClient,
        this.keyholdersSentClient,
        this.keyholdersReceivedClient,
        this.urnSentClient,
        this.urnReceivedClient,
        this.urnAppliedPoliceForce,
        this.urnReceivedPoliceForce,
        this.jobExtraStockReturnFaulty,
        this.jobPaymentToCollect,
        this.completedTechnicalNotes,
        this.jobTaskTimestamp,
        this.hdnprofitTotal,
        this.jobListingNotes,
        this.jobNotesUserId,
        this.jobType,
        this.soJobStatus,
        this.scheduleDateStart,
        this.scheduleTimeStart,
        this.scheduleTimeEnd,
        this.scheduleEngineerNotes,
        this.scheduleRevisitDescription,
        this.isscheduledjob,
        this.breWorksCompleted,
        this.breRevisitRequired,
        this.brePartsRequired,
        this.breAnyPartsUsed,
        this.brePaymentCollected,
        this.breSystemLeftWork,
        this.breCheTimeDate,
        this.breCsDigiNo,
        this.breInstalled,
        this.breRemSignal,
        this.breLastVisit,
        this.brePolice,
        this.breArriTime,
        this.breDeparTime,
        this.brePartsMakeModel,
        this.brePartsMakeModelQty,
        this.breDisablePartOfSys,
        this.breOnsiteTime,
        this.breArivalToDepart,
        this.serFusedCorrFitt,
        this.serFusedCorrFittNotes,
        this.serBattFreeCorr,
        this.serBattFreeCorrNotes,
        this.serBattUnderYear,
        this.serBattUnderYearNotes,
        this.serBattChargVolt,
        this.serBattChargVoltValue,
        this.serBattPassLoad,
        this.serBattPassLoadRepl,
        this.serBattPassreplApprov,
        this.serBattTakeover,
        this.serBattChargRateVal,
        this.serBattChargRateNotes,
        this.serBattVoltMinVal,
        this.serBattVoltMinNotes,
        this.serCommsFaultPanel,
        this.serCommsFaultPanelNotes,
        this.serChanSignalToArc,
        this.serChanSignalToArcNotes,
        this.serSignalRecByArc,
        this.serSignalRecByArcNotes,
        this.serCheFreeTempFal,
        this.serCheFreeTempFalNotes,
        this.serCheZoneDisable,
        this.serCheZoneDisableReason,
        this.serCheZoneDisNotifi,
        this.serCheZoneDisActReq,
        this.serTimeDateCorr,
        this.serTimeDateCorrNotes,
        this.serLeftWorkOrder,
        this.serLeftWorkOrderNotes,
        this.serPartWorkReaList,
        this.serReasPartWorking,
        this.serReasPartWorkNotifi,
        this.serReasPartWorkActReq,
        this.breCustomerSignName,
        this.breCustomerSign,
        this.breCustomerSignDate,
        this.breEngineerSignName,
        this.breEngineerSign,
        this.breEngineerSignDate,
        this.jobCsDigiCheck,
        this.jobCsDigiNumber,
        this.serCctvCameraViCheck,
        this.serCctvCameraViCheckNotes,
        this.serCctvCameraInFocus,
        this.serCctvCameraInFocusNotes,
        this.serCctvCameraQuaAtNight,
        this.serCctvCameraQuaAtNightNotes,
        this.serCctvPlaybackReco,
        this.serCctvNoOfDayStorage,
        this.serCctvDvrNvrCond,
        this.serCctvDvrNvrCondNotes,
        this.serCctvMoniScrCond,
        this.serCctvMoniScrCondNotes,
        this.serCctvSysDocAvilSite,
        this.serCctvReqDocument,
        this.serCctvSysCondi,
        this.serCctvDvrNvrTimeDate,
        this.jobIssueNsiCert,
        this.jobIssueNsiCertNumber,
        this.jobIntZoneNumber,
        this.jobIntZoneNodeNumber,
        this.jobIntZoneLocations,
        this.jobIntZoneDeviceType,
        this.jobIntZoneType,
        this.jobIntZoneWalkTested,
        this.jobIntZonePassed,
        this.jobIntBattPowerSupplyNo,
        this.jobIntBattPsuLocation,
        this.jobIntBattBatteryAmps,
        this.jobIntBattBatteryVoltage,
        this.jobIntBattPsuVoltage,
        this.jobIntBattBatteryLab,
        this.jobIntBattBatteryPassed,
        this.jobIntBattPsuPassed,
        this.jobIntruSounderNumber,
        this.jobIntruSounderLocations,
        this.jobIntruSounderTested,
        this.jobIntruHoldupTested,
        this.jobIntruStrobeTest,
        this.jobIntruControlPanelMake,
        this.jobIntruControlPanelLocations,
        this.jobIntruPanelBattCurrent,
        this.jobIntruPanelPsuBattCurr,
        this.jobIntruPanelKeypadNo,
        this.jobIntruPanelKeypadLocat,
        this.jobIntruPanelRestUponEntry,
        this.jobIntruPanelFused,
        this.jobIntruPanelPsuFused,
        this.jobIntruTimersBellDelay,
        this.jobIntruTimersBellDuration,
        this.jobIntruTimersEntryTime,
        this.jobIntruTimersExitTime,
        this.jobIntruCommsconnLineNo,
        this.jobIntruCommsconnRemAccess,
        this.jobIntruCommsconnSystemid,
        this.jobIntruCommsconnSoftVer,
        this.jobIntEngScPanel,
        this.jobIntEngAlarmTel,
        this.jobIntEngScPanic,
        this.jobIntEngHealthSafety,
        this.jobIntEngSystemCondition,
        this.jobIntEngBuildStandard,
        this.jobIntEngSignalingChanel,
        this.engJobNotes,
        this.jobSchBookedBy,
        this.jobIntruSoftVer,
        this.jobIntruPanelType,
        this.jobIntruInstalledDate,
        this.jobIntruSignalType,
        this.jobIntruIpAddress,
        this.jobIntruChip,
        this.jobIntruSysTestArc,
        this.jobIntruArc,
        this.jobIntruInfCusAlarmTest,
        this.jobRejectedNotes,
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
        this.isJobScheduleMailSent,
        this.jobQrcodePreview,
        this.jobSmsSentLog,
        this.jobChecklistStockRequire,
        this.jobChecklistPayRecived,
        this.jobChecklistDdRecSubSetup,
        this.jobServiServiceMonth,
        this.jobServiPerAnnum,
        this.jobServiServiceYear,
        this.jobServiServiceType,
        this.salesorderRelatedId,
        this.isCustomerConfirm,
        this.jobSchDateByCustomer,
        this.jobSchAltDateByCustomer,
        this.jobSchCustomerNotes,
        this.jobWhatThreeWord,
        this.isProjectTaskCreatedAsana,
        this.asanaCreatedProjectId,
        this.jobPartStatus,
        this.jotformWorkCarryOut,
        this.jotformOutStandWork,
        this.jotformPartReqNextVisit,
        this.jotformAddWorkToQuote,
        this.jotformPartUsed,
        this.id,
        this.contactName,
        this.assignedUserName,
        this.lineItems});

  Result.fromJson(Map<String, dynamic> json) {
    salesorderNo = json['salesorder_no'];
    subject = json['subject'];
    potentialId = json['potential_id'];
    customerno = json['customerno'];
    quoteId = json['quote_id'];
    vtigerPurchaseorder = json['vtiger_purchaseorder'];
    contactId = json['contact_id'];
    duedate = json['duedate'];
    carrier = json['carrier'];
    pending = json['pending'];
    sostatus = json['sostatus'];
    txtAdjustment = json['txtAdjustment'];
    salescommission = json['salescommission'];
    exciseduty = json['exciseduty'];
    hdnGrandTotal = json['hdnGrandTotal'];
    hdnSubTotal = json['hdnSubTotal'];
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
    enableRecurring = json['enable_recurring'];
    recurringFrequency = json['recurring_frequency'];
    startPeriod = json['start_period'];
    endPeriod = json['end_period'];
    paymentDuration = json['payment_duration'];
    invoicestatus = json['invoicestatus'];
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
    extQty = json['ext_qty'];
    checkStockAvailability = json['check_stock_availability'];
    createJobsheet = json['create_jobsheet'];
    allocateEngineers = json['allocate_engineers'];
    confirmAppointment = json['confirm_appointment'];
    dispatchJobsheet = json['dispatch_jobsheet'];
    collectDepositPayment = json['collect_deposit_payment'];
    raiseInvoice = json['raise_invoice'];
    orderStockRequired = json['order_stock_required'];
    allocateStockUponReceipt = json['allocate_stock_upon_receipt'];
    pickOutStockJob = json['pick_out_stock_job'];
    bookWorkClient = json['book_work_client'];
    requestInstruction = json['request_instruction'];
    rebbokRevisits = json['rebbok_revisits'];
    callUpdateNotes = json['call_update_notes'];
    completionCheckWork = json['completion_check_work'];
    customerFeedback = json['customer_feedback'];
    notesPaymentCompletion = json['notes_payment_completion'];
    paymentCollectedEngineer = json['payment_collected_engineer'];
    sendInvoiceCompletion = json['send_invoice_completion'];
    passStockToEngineer = json['pass_stock_to_engineer'];
    passCommsToEngineer = json['pass_comms_to_engineer'];
    arrangeAddition = json['arrange_addition'];
    stockForRevisit = json['stock_for_revisit'];
    pickStockForRevisit = json['pick_stock_for_revisit'];
    collectStockFromEngineer = json['collect_stock_from_engineer'];
    setupTestRemoteAccess = json['setup_test_remote_access'];
    createContract = json['create_contract'];
    orderComms = json['order_comms'];
    applyUrn = json['apply_urn'];
    sendEngineerDocument = json['send_engineer_document'];
    maintenanceAgreement = json['maintenance_agreement'];
    jobProgress = json['job_progress'];
    jobCompany = json['job_company'];
    floorPlanDocsJob = json['floor_plan_docs_job'];
    contractNumber = json['contract_number'];
    jobSystemType = json['job_system_type'];
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
    flaggedDate = json['flagged_date'];
    flaggedNotes = json['flagged_notes'];
    closeJob = json['close_job'];
    maintenanceSentClient = json['maintenance_sent_client'];
    maintenanceReceivedClient = json['maintenance_received_client'];
    keyholdersSentClient = json['keyholders_sent_client'];
    keyholdersReceivedClient = json['keyholders_received_client'];
    urnSentClient = json['urn_sent_client'];
    urnReceivedClient = json['urn_received_client'];
    urnAppliedPoliceForce = json['urn_applied_police_force'];
    urnReceivedPoliceForce = json['urn_received_police_force'];
    jobExtraStockReturnFaulty = json['job_extra_stock_return_faulty'];
    jobPaymentToCollect = json['job_payment_to_collect'];
    completedTechnicalNotes = json['completed_technical_notes'];
    jobTaskTimestamp = json['job_task_timestamp'];
    hdnprofitTotal = json['hdnprofitTotal'];
    jobListingNotes = json['job_listing_notes'];
    jobNotesUserId = json['job_notes_user_id'];
    jobType = json['job_type'];
    soJobStatus = json['so_job_status'];
    scheduleDateStart = json['schedule_date_start'];
    scheduleTimeStart = json['schedule_time_start'];
    scheduleTimeEnd = json['schedule_time_end'];
    scheduleEngineerNotes = json['schedule_engineer_notes'];
    scheduleRevisitDescription = json['schedule_revisit_description'];
    isscheduledjob = json['isscheduledjob'];
    breWorksCompleted = json['bre_works_completed'];
    breRevisitRequired = json['bre_revisit_required'];
    brePartsRequired = json['bre_parts_required'];
    breAnyPartsUsed = json['bre_any_parts_used'];
    brePaymentCollected = json['bre_payment_collected'];
    breSystemLeftWork = json['bre_system_left_work'];
    breCheTimeDate = json['bre_che_time_date'];
    breCsDigiNo = json['bre_cs_digi_no'];
    breInstalled = json['bre_installed'];
    breRemSignal = json['bre_rem_signal'];
    breLastVisit = json['bre_last_visit'];
    brePolice = json['bre_police'];
    breArriTime = json['bre_arri_time'];
    breDeparTime = json['bre_depar_time'];
    brePartsMakeModel = json['bre_parts_make_model'];
    brePartsMakeModelQty = json['bre_parts_make_model_qty'];
    breDisablePartOfSys = json['bre_disable_part_of_sys'];
    breOnsiteTime = json['bre_onsite_time'];
    breArivalToDepart = json['bre_arival_to_depart'];
    serFusedCorrFitt = json['ser_fused_corr_fitt'];
    serFusedCorrFittNotes = json['ser_fused_corr_fitt_notes'];
    serBattFreeCorr = json['ser_batt_free_corr'];
    serBattFreeCorrNotes = json['ser_batt_free_corr_notes'];
    serBattUnderYear = json['ser_batt_under_year'];
    serBattUnderYearNotes = json['ser_batt_under_year_notes'];
    serBattChargVolt = json['ser_batt_charg_volt'];
    serBattChargVoltValue = json['ser_batt_charg_volt_value'];
    serBattPassLoad = json['ser_batt_pass_load'];
    serBattPassLoadRepl = json['ser_batt_pass_load_repl'];
    serBattPassreplApprov = json['ser_batt_passrepl_approv'];
    serBattTakeover = json['ser_batt_takeover'];
    serBattChargRateVal = json['ser_batt_charg_rate_val'];
    serBattChargRateNotes = json['ser_batt_charg_rate_notes'];
    serBattVoltMinVal = json['ser_batt_volt_min_val'];
    serBattVoltMinNotes = json['ser_batt_volt_min_notes'];
    serCommsFaultPanel = json['ser_comms_fault_panel'];
    serCommsFaultPanelNotes = json['ser_comms_fault_panel_notes'];
    serChanSignalToArc = json['ser_chan_signal_to_arc'];
    serChanSignalToArcNotes = json['ser_chan_signal_to_arc_notes'];
    serSignalRecByArc = json['ser_signal_rec_by_arc'];
    serSignalRecByArcNotes = json['ser_signal_rec_by_arc_notes'];
    serCheFreeTempFal = json['ser_che_free_temp_fal'];
    serCheFreeTempFalNotes = json['ser_che_free_temp_fal_notes'];
    serCheZoneDisable = json['ser_che_zone_disable'];
    serCheZoneDisableReason = json['ser_che_zone_disable_reason'];
    serCheZoneDisNotifi = json['ser_che_zone_dis_notifi'];
    serCheZoneDisActReq = json['ser_che_zone_dis_Act_req'];
    serTimeDateCorr = json['ser_time_date_corr'];
    serTimeDateCorrNotes = json['ser_time_date_corr_notes'];
    serLeftWorkOrder = json['ser_left_work_order'];
    serLeftWorkOrderNotes = json['ser_left_work_order_notes'];
    serPartWorkReaList = json['ser_part_work_rea_list'];
    serReasPartWorking = json['ser_reas_part_working'];
    serReasPartWorkNotifi = json['ser_reas_part_work_notifi'];
    serReasPartWorkActReq = json['ser_reas_part_work_Act_req'];
    breCustomerSignName = json['bre_customer_sign_name'];
    breCustomerSign = json['bre_customer_sign'];
    breCustomerSignDate = json['bre_customer_sign_date'];
    breEngineerSignName = json['bre_engineer_sign_name'];
    breEngineerSign = json['bre_engineer_sign'];
    breEngineerSignDate = json['bre_engineer_sign_date'];
    jobCsDigiCheck = json['job_cs_digi_check'];
    jobCsDigiNumber = json['job_cs_digi_number'];
    serCctvCameraViCheck = json['ser_cctv_camera_vi_check'];
    serCctvCameraViCheckNotes = json['ser_cctv_camera_vi_check_notes'];
    serCctvCameraInFocus = json['ser_cctv_camera_in_focus'];
    serCctvCameraInFocusNotes = json['ser_cctv_camera_in_focus_notes'];
    serCctvCameraQuaAtNight = json['ser_cctv_camera_qua_at_night'];
    serCctvCameraQuaAtNightNotes = json['ser_cctv_camera_qua_at_night_notes'];
    serCctvPlaybackReco = json['ser_cctv_playback_reco'];
    serCctvNoOfDayStorage = json['ser_cctv_no_of_day_storage'];
    serCctvDvrNvrCond = json['ser_cctv_dvr_nvr_cond'];
    serCctvDvrNvrCondNotes = json['ser_cctv_dvr_nvr_cond_notes'];
    serCctvMoniScrCond = json['ser_cctv_moni_scr_cond'];
    serCctvMoniScrCondNotes = json['ser_cctv_moni_scr_cond_notes'];
    serCctvSysDocAvilSite = json['ser_cctv_sys_doc_avil_site'];
    serCctvReqDocument = json['ser_cctv_req_document'];
    serCctvSysCondi = json['ser_cctv_sys_condi'];
    serCctvDvrNvrTimeDate = json['ser_cctv_dvr_nvr_time_date'];
    jobIssueNsiCert = json['job_issue_nsi_cert'];
    jobIssueNsiCertNumber = json['job_issue_nsi_cert_number'];
    jobIntZoneNumber = json['job_int_zone_number'];
    jobIntZoneNodeNumber = json['job_int_zone_node_number'];
    jobIntZoneLocations = json['job_int_zone_locations'];
    jobIntZoneDeviceType = json['job_int_zone_device_type'];
    jobIntZoneType = json['job_int_zone_type'];
    jobIntZoneWalkTested = json['job_int_zone_walk_tested'];
    jobIntZonePassed = json['job_int_zone_passed'];
    jobIntBattPowerSupplyNo = json['job_int_batt_power_supply_no'];
    jobIntBattPsuLocation = json['job_int_batt_psu_location'];
    jobIntBattBatteryAmps = json['job_int_batt_battery_amps'];
    jobIntBattBatteryVoltage = json['job_int_batt_battery_voltage'];
    jobIntBattPsuVoltage = json['job_int_batt_psu_voltage'];
    jobIntBattBatteryLab = json['job_int_batt_battery_lab'];
    jobIntBattBatteryPassed = json['job_int_batt_battery_passed'];
    jobIntBattPsuPassed = json['job_int_batt_psu_passed'];
    jobIntruSounderNumber = json['job_intru_sounder_number'];
    jobIntruSounderLocations = json['job_intru_sounder_locations'];
    jobIntruSounderTested = json['job_intru_sounder_tested'];
    jobIntruHoldupTested = json['job_intru_holdup_tested'];
    jobIntruStrobeTest = json['job_intru_strobe_test'];
    jobIntruControlPanelMake = json['job_intru_control_panel_make'];
    jobIntruControlPanelLocations = json['job_intru_control_panel_locations'];
    jobIntruPanelBattCurrent = json['job_intru_panel_batt_current'];
    jobIntruPanelPsuBattCurr = json['job_intru_panel_psu_batt_curr'];
    jobIntruPanelKeypadNo = json['job_intru_panel_keypad_no'];
    jobIntruPanelKeypadLocat = json['job_intru_panel_keypad_locat'];
    jobIntruPanelRestUponEntry = json['job_intru_panel_rest_upon_entry'];
    jobIntruPanelFused = json['job_intru_panel_fused'];
    jobIntruPanelPsuFused = json['job_intru_panel_psu_fused'];
    jobIntruTimersBellDelay = json['job_intru_timers_bell_delay'];
    jobIntruTimersBellDuration = json['job_intru_timers_bell_duration'];
    jobIntruTimersEntryTime = json['job_intru_timers_entry_time'];
    jobIntruTimersExitTime = json['job_intru_timers_exit_time'];
    jobIntruCommsconnLineNo = json['job_intru_commsconn_line_no'];
    jobIntruCommsconnRemAccess = json['job_intru_commsconn_rem_access'];
    jobIntruCommsconnSystemid = json['job_intru_commsconn_systemid'];
    jobIntruCommsconnSoftVer = json['job_intru_commsconn_soft_ver'];
    jobIntEngScPanel = json['job_int_eng_sc_panel'];
    jobIntEngAlarmTel = json['job_int_eng_alarm_tel'];
    jobIntEngScPanic = json['job_int_eng_sc_panic'];
    jobIntEngHealthSafety = json['job_int_eng_health_safety'];
    jobIntEngSystemCondition = json['job_int_eng_system_condition'];
    jobIntEngBuildStandard = json['job_int_eng_build_standard'];
    jobIntEngSignalingChanel = json['job_int_eng_signaling_chanel'];
    engJobNotes = json['eng_job_notes'];
    jobSchBookedBy = json['job_sch_booked_by'];
    jobIntruSoftVer = json['job_intru_soft_ver'];
    jobIntruPanelType = json['job_intru_panel_type'];
    jobIntruInstalledDate = json['job_intru_installed_date'];
    jobIntruSignalType = json['job_intru_signal_type'];
    jobIntruIpAddress = json['job_intru_ip_address'];
    jobIntruChip = json['job_intru_chip'];
    jobIntruSysTestArc = json['job_intru_sys_test_arc'];
    jobIntruArc = json['job_intru_arc'];
    jobIntruInfCusAlarmTest = json['job_intru_inf_cus_alarm_test'];
    jobRejectedNotes = json['job_rejected_notes'];
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
    isJobScheduleMailSent = json['is_job_schedule_mail_sent'];
    jobQrcodePreview = json['job_qrcode_preview'];
    jobSmsSentLog = json['job_sms_sent_log'];
    jobChecklistStockRequire = json['job_checklist_stock_require'];
    jobChecklistPayRecived = json['job_checklist_pay_recived'];
    jobChecklistDdRecSubSetup = json['job_checklist_dd_rec_sub_setup'];
    jobServiServiceMonth = json['job_servi_service_month'];
    jobServiPerAnnum = json['job_servi_per_annum'];
    jobServiServiceYear = json['job_servi_service_year'];
    jobServiServiceType = json['job_servi_service_type'];
    salesorderRelatedId = json['salesorder_related_id'];
    isCustomerConfirm = json['is_customer_confirm'];
    jobSchDateByCustomer = json['job_sch_date_by_customer'];
    jobSchAltDateByCustomer = json['job_sch_alt_date_by_customer'];
    jobSchCustomerNotes = json['job_sch_customer_notes'];
    jobWhatThreeWord = json['job_what_three_word'];
    isProjectTaskCreatedAsana = json['is_project_task_created_asana'];
    asanaCreatedProjectId = json['asana_created_project_id'];
    jobPartStatus = json['job_part_status'];
    jotformWorkCarryOut = json['jotform_work_carry_out'];
    jotformOutStandWork = json['jotform_out_stand_work'];
    jotformPartReqNextVisit = json['jotform_part_req_next_visit'];
    jotformAddWorkToQuote = json['jotform_add_work_to_quote'];
    jotformPartUsed = json['jotform_part_used'];
    id = json['id'];
    contactName = json['contact_name'];
    assignedUserName = json['assigned_user_name'];
    if (json['LineItems'] != null) {
      lineItems = <LineItems>[];
      json['LineItems'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salesorder_no'] = salesorderNo;
    data['subject'] = subject;
    data['potential_id'] = potentialId;
    data['customerno'] = customerno;
    data['quote_id'] = quoteId;
    data['vtiger_purchaseorder'] = vtigerPurchaseorder;
    data['contact_id'] = contactId;
    data['duedate'] = duedate;
    data['carrier'] = carrier;
    data['pending'] = pending;
    data['sostatus'] = sostatus;
    data['txtAdjustment'] = txtAdjustment;
    data['salescommission'] = salescommission;
    data['exciseduty'] = exciseduty;
    data['hdnGrandTotal'] = hdnGrandTotal;
    data['hdnSubTotal'] = hdnSubTotal;
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
    data['enable_recurring'] = enableRecurring;
    data['recurring_frequency'] = recurringFrequency;
    data['start_period'] = startPeriod;
    data['end_period'] = endPeriod;
    data['payment_duration'] = paymentDuration;
    data['invoicestatus'] = invoicestatus;
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
    data['ext_qty'] = extQty;
    data['check_stock_availability'] = checkStockAvailability;
    data['create_jobsheet'] = createJobsheet;
    data['allocate_engineers'] = allocateEngineers;
    data['confirm_appointment'] = confirmAppointment;
    data['dispatch_jobsheet'] = dispatchJobsheet;
    data['collect_deposit_payment'] = collectDepositPayment;
    data['raise_invoice'] = raiseInvoice;
    data['order_stock_required'] = orderStockRequired;
    data['allocate_stock_upon_receipt'] = allocateStockUponReceipt;
    data['pick_out_stock_job'] = pickOutStockJob;
    data['book_work_client'] = bookWorkClient;
    data['request_instruction'] = requestInstruction;
    data['rebbok_revisits'] = rebbokRevisits;
    data['call_update_notes'] = callUpdateNotes;
    data['completion_check_work'] = completionCheckWork;
    data['customer_feedback'] = customerFeedback;
    data['notes_payment_completion'] = notesPaymentCompletion;
    data['payment_collected_engineer'] = paymentCollectedEngineer;
    data['send_invoice_completion'] = sendInvoiceCompletion;
    data['pass_stock_to_engineer'] = passStockToEngineer;
    data['pass_comms_to_engineer'] = passCommsToEngineer;
    data['arrange_addition'] = arrangeAddition;
    data['stock_for_revisit'] = stockForRevisit;
    data['pick_stock_for_revisit'] = pickStockForRevisit;
    data['collect_stock_from_engineer'] = collectStockFromEngineer;
    data['setup_test_remote_access'] = setupTestRemoteAccess;
    data['create_contract'] = createContract;
    data['order_comms'] = orderComms;
    data['apply_urn'] = applyUrn;
    data['send_engineer_document'] = sendEngineerDocument;
    data['maintenance_agreement'] = maintenanceAgreement;
    data['job_progress'] = jobProgress;
    data['job_company'] = jobCompany;
    data['floor_plan_docs_job'] = floorPlanDocsJob;
    data['contract_number'] = contractNumber;
    data['job_system_type'] = jobSystemType;
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
    data['flagged_date'] = flaggedDate;
    data['flagged_notes'] = flaggedNotes;
    data['close_job'] = closeJob;
    data['maintenance_sent_client'] = maintenanceSentClient;
    data['maintenance_received_client'] = maintenanceReceivedClient;
    data['keyholders_sent_client'] = keyholdersSentClient;
    data['keyholders_received_client'] = keyholdersReceivedClient;
    data['urn_sent_client'] = urnSentClient;
    data['urn_received_client'] = urnReceivedClient;
    data['urn_applied_police_force'] = urnAppliedPoliceForce;
    data['urn_received_police_force'] = urnReceivedPoliceForce;
    data['job_extra_stock_return_faulty'] = jobExtraStockReturnFaulty;
    data['job_payment_to_collect'] = jobPaymentToCollect;
    data['completed_technical_notes'] = completedTechnicalNotes;
    data['job_task_timestamp'] = jobTaskTimestamp;
    data['hdnprofitTotal'] = hdnprofitTotal;
    data['job_listing_notes'] = jobListingNotes;
    data['job_notes_user_id'] = jobNotesUserId;
    data['job_type'] = jobType;
    data['so_job_status'] = soJobStatus;
    data['schedule_date_start'] = scheduleDateStart;
    data['schedule_time_start'] = scheduleTimeStart;
    data['schedule_time_end'] = scheduleTimeEnd;
    data['schedule_engineer_notes'] = scheduleEngineerNotes;
    data['schedule_revisit_description'] = scheduleRevisitDescription;
    data['isscheduledjob'] = isscheduledjob;
    data['bre_works_completed'] = breWorksCompleted;
    data['bre_revisit_required'] = breRevisitRequired;
    data['bre_parts_required'] = brePartsRequired;
    data['bre_any_parts_used'] = breAnyPartsUsed;
    data['bre_payment_collected'] = brePaymentCollected;
    data['bre_system_left_work'] = breSystemLeftWork;
    data['bre_che_time_date'] = breCheTimeDate;
    data['bre_cs_digi_no'] = breCsDigiNo;
    data['bre_installed'] = breInstalled;
    data['bre_rem_signal'] = breRemSignal;
    data['bre_last_visit'] = breLastVisit;
    data['bre_police'] = brePolice;
    data['bre_arri_time'] = breArriTime;
    data['bre_depar_time'] = breDeparTime;
    data['bre_parts_make_model'] = brePartsMakeModel;
    data['bre_parts_make_model_qty'] = brePartsMakeModelQty;
    data['bre_disable_part_of_sys'] = breDisablePartOfSys;
    data['bre_onsite_time'] = breOnsiteTime;
    data['bre_arival_to_depart'] = breArivalToDepart;
    data['ser_fused_corr_fitt'] = serFusedCorrFitt;
    data['ser_fused_corr_fitt_notes'] = serFusedCorrFittNotes;
    data['ser_batt_free_corr'] = serBattFreeCorr;
    data['ser_batt_free_corr_notes'] = serBattFreeCorrNotes;
    data['ser_batt_under_year'] = serBattUnderYear;
    data['ser_batt_under_year_notes'] = serBattUnderYearNotes;
    data['ser_batt_charg_volt'] = serBattChargVolt;
    data['ser_batt_charg_volt_value'] = serBattChargVoltValue;
    data['ser_batt_pass_load'] = serBattPassLoad;
    data['ser_batt_pass_load_repl'] = serBattPassLoadRepl;
    data['ser_batt_passrepl_approv'] = serBattPassreplApprov;
    data['ser_batt_takeover'] = serBattTakeover;
    data['ser_batt_charg_rate_val'] = serBattChargRateVal;
    data['ser_batt_charg_rate_notes'] = serBattChargRateNotes;
    data['ser_batt_volt_min_val'] = serBattVoltMinVal;
    data['ser_batt_volt_min_notes'] = serBattVoltMinNotes;
    data['ser_comms_fault_panel'] = serCommsFaultPanel;
    data['ser_comms_fault_panel_notes'] = serCommsFaultPanelNotes;
    data['ser_chan_signal_to_arc'] = serChanSignalToArc;
    data['ser_chan_signal_to_arc_notes'] = serChanSignalToArcNotes;
    data['ser_signal_rec_by_arc'] = serSignalRecByArc;
    data['ser_signal_rec_by_arc_notes'] = serSignalRecByArcNotes;
    data['ser_che_free_temp_fal'] = serCheFreeTempFal;
    data['ser_che_free_temp_fal_notes'] = serCheFreeTempFalNotes;
    data['ser_che_zone_disable'] = serCheZoneDisable;
    data['ser_che_zone_disable_reason'] = serCheZoneDisableReason;
    data['ser_che_zone_dis_notifi'] = serCheZoneDisNotifi;
    data['ser_che_zone_dis_Act_req'] = serCheZoneDisActReq;
    data['ser_time_date_corr'] = serTimeDateCorr;
    data['ser_time_date_corr_notes'] = serTimeDateCorrNotes;
    data['ser_left_work_order'] = serLeftWorkOrder;
    data['ser_left_work_order_notes'] = serLeftWorkOrderNotes;
    data['ser_part_work_rea_list'] = serPartWorkReaList;
    data['ser_reas_part_working'] = serReasPartWorking;
    data['ser_reas_part_work_notifi'] = serReasPartWorkNotifi;
    data['ser_reas_part_work_Act_req'] = serReasPartWorkActReq;
    data['bre_customer_sign_name'] = breCustomerSignName;
    data['bre_customer_sign'] = breCustomerSign;
    data['bre_customer_sign_date'] = breCustomerSignDate;
    data['bre_engineer_sign_name'] = breEngineerSignName;
    data['bre_engineer_sign'] = breEngineerSign;
    data['bre_engineer_sign_date'] = breEngineerSignDate;
    data['job_cs_digi_check'] = jobCsDigiCheck;
    data['job_cs_digi_number'] = jobCsDigiNumber;
    data['ser_cctv_camera_vi_check'] = serCctvCameraViCheck;
    data['ser_cctv_camera_vi_check_notes'] = serCctvCameraViCheckNotes;
    data['ser_cctv_camera_in_focus'] = serCctvCameraInFocus;
    data['ser_cctv_camera_in_focus_notes'] = serCctvCameraInFocusNotes;
    data['ser_cctv_camera_qua_at_night'] = serCctvCameraQuaAtNight;
    data['ser_cctv_camera_qua_at_night_notes'] =
        serCctvCameraQuaAtNightNotes;
    data['ser_cctv_playback_reco'] = serCctvPlaybackReco;
    data['ser_cctv_no_of_day_storage'] = serCctvNoOfDayStorage;
    data['ser_cctv_dvr_nvr_cond'] = serCctvDvrNvrCond;
    data['ser_cctv_dvr_nvr_cond_notes'] = serCctvDvrNvrCondNotes;
    data['ser_cctv_moni_scr_cond'] = serCctvMoniScrCond;
    data['ser_cctv_moni_scr_cond_notes'] = serCctvMoniScrCondNotes;
    data['ser_cctv_sys_doc_avil_site'] = serCctvSysDocAvilSite;
    data['ser_cctv_req_document'] = serCctvReqDocument;
    data['ser_cctv_sys_condi'] = serCctvSysCondi;
    data['ser_cctv_dvr_nvr_time_date'] = serCctvDvrNvrTimeDate;
    data['job_issue_nsi_cert'] = jobIssueNsiCert;
    data['job_issue_nsi_cert_number'] = jobIssueNsiCertNumber;
    data['job_int_zone_number'] = jobIntZoneNumber;
    data['job_int_zone_node_number'] = jobIntZoneNodeNumber;
    data['job_int_zone_locations'] = jobIntZoneLocations;
    data['job_int_zone_device_type'] = jobIntZoneDeviceType;
    data['job_int_zone_type'] = jobIntZoneType;
    data['job_int_zone_walk_tested'] = jobIntZoneWalkTested;
    data['job_int_zone_passed'] = jobIntZonePassed;
    data['job_int_batt_power_supply_no'] = jobIntBattPowerSupplyNo;
    data['job_int_batt_psu_location'] = jobIntBattPsuLocation;
    data['job_int_batt_battery_amps'] = jobIntBattBatteryAmps;
    data['job_int_batt_battery_voltage'] = jobIntBattBatteryVoltage;
    data['job_int_batt_psu_voltage'] = jobIntBattPsuVoltage;
    data['job_int_batt_battery_lab'] = jobIntBattBatteryLab;
    data['job_int_batt_battery_passed'] = jobIntBattBatteryPassed;
    data['job_int_batt_psu_passed'] = jobIntBattPsuPassed;
    data['job_intru_sounder_number'] = jobIntruSounderNumber;
    data['job_intru_sounder_locations'] = jobIntruSounderLocations;
    data['job_intru_sounder_tested'] = jobIntruSounderTested;
    data['job_intru_holdup_tested'] = jobIntruHoldupTested;
    data['job_intru_strobe_test'] = jobIntruStrobeTest;
    data['job_intru_control_panel_make'] = jobIntruControlPanelMake;
    data['job_intru_control_panel_locations'] =
        jobIntruControlPanelLocations;
    data['job_intru_panel_batt_current'] = jobIntruPanelBattCurrent;
    data['job_intru_panel_psu_batt_curr'] = jobIntruPanelPsuBattCurr;
    data['job_intru_panel_keypad_no'] = jobIntruPanelKeypadNo;
    data['job_intru_panel_keypad_locat'] = jobIntruPanelKeypadLocat;
    data['job_intru_panel_rest_upon_entry'] = jobIntruPanelRestUponEntry;
    data['job_intru_panel_fused'] = jobIntruPanelFused;
    data['job_intru_panel_psu_fused'] = jobIntruPanelPsuFused;
    data['job_intru_timers_bell_delay'] = jobIntruTimersBellDelay;
    data['job_intru_timers_bell_duration'] = jobIntruTimersBellDuration;
    data['job_intru_timers_entry_time'] = jobIntruTimersEntryTime;
    data['job_intru_timers_exit_time'] = jobIntruTimersExitTime;
    data['job_intru_commsconn_line_no'] = jobIntruCommsconnLineNo;
    data['job_intru_commsconn_rem_access'] = jobIntruCommsconnRemAccess;
    data['job_intru_commsconn_systemid'] = jobIntruCommsconnSystemid;
    data['job_intru_commsconn_soft_ver'] = jobIntruCommsconnSoftVer;
    data['job_int_eng_sc_panel'] = jobIntEngScPanel;
    data['job_int_eng_alarm_tel'] = jobIntEngAlarmTel;
    data['job_int_eng_sc_panic'] = jobIntEngScPanic;
    data['job_int_eng_health_safety'] = jobIntEngHealthSafety;
    data['job_int_eng_system_condition'] = jobIntEngSystemCondition;
    data['job_int_eng_build_standard'] = jobIntEngBuildStandard;
    data['job_int_eng_signaling_chanel'] = jobIntEngSignalingChanel;
    data['eng_job_notes'] = engJobNotes;
    data['job_sch_booked_by'] = jobSchBookedBy;
    data['job_intru_soft_ver'] = jobIntruSoftVer;
    data['job_intru_panel_type'] = jobIntruPanelType;
    data['job_intru_installed_date'] = jobIntruInstalledDate;
    data['job_intru_signal_type'] = jobIntruSignalType;
    data['job_intru_ip_address'] = jobIntruIpAddress;
    data['job_intru_chip'] = jobIntruChip;
    data['job_intru_sys_test_arc'] = jobIntruSysTestArc;
    data['job_intru_arc'] = jobIntruArc;
    data['job_intru_inf_cus_alarm_test'] = jobIntruInfCusAlarmTest;
    data['job_rejected_notes'] = jobRejectedNotes;
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
    data['is_job_schedule_mail_sent'] = isJobScheduleMailSent;
    data['job_qrcode_preview'] = jobQrcodePreview;
    data['job_sms_sent_log'] = jobSmsSentLog;
    data['job_checklist_stock_require'] = jobChecklistStockRequire;
    data['job_checklist_pay_recived'] = jobChecklistPayRecived;
    data['job_checklist_dd_rec_sub_setup'] = jobChecklistDdRecSubSetup;
    data['job_servi_service_month'] = jobServiServiceMonth;
    data['job_servi_per_annum'] = jobServiPerAnnum;
    data['job_servi_service_year'] = jobServiServiceYear;
    data['job_servi_service_type'] = jobServiServiceType;
    data['salesorder_related_id'] = salesorderRelatedId;
    data['is_customer_confirm'] = isCustomerConfirm;
    data['job_sch_date_by_customer'] = jobSchDateByCustomer;
    data['job_sch_alt_date_by_customer'] = jobSchAltDateByCustomer;
    data['job_sch_customer_notes'] = jobSchCustomerNotes;
    data['job_what_three_word'] = jobWhatThreeWord;
    data['is_project_task_created_asana'] = isProjectTaskCreatedAsana;
    data['asana_created_project_id'] = asanaCreatedProjectId;
    data['job_part_status'] = jobPartStatus;
    data['jotform_work_carry_out'] = jotformWorkCarryOut;
    data['jotform_out_stand_work'] = jotformOutStandWork;
    data['jotform_part_req_next_visit'] = jotformPartReqNextVisit;
    data['jotform_add_work_to_quote'] = jotformAddWorkToQuote;
    data['jotform_part_used'] = jotformPartUsed;
    data['id'] = id;
    data['contact_name'] = contactName;
    data['assigned_user_name'] = assignedUserName;
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