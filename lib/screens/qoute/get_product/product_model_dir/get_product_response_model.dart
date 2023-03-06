class GetProductData {
  bool? success;
  List<Result>? result;

  GetProductData({this.success, this.result});

  GetProductData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? productname;
  String? productNo;
  String? productcode;
  String? discontinued;
  String? salesStartDate;
  String? salesEndDate;
  String? startDate;
  String? expiryDate;
  String? website;
  String? vendorId;
  String? mfrPartNo;
  String? vendorPartNo;
  String? serialNo;
  String? productsheet;
  String? glacct;
  String? createdtime;
  String? modifiedtime;
  String? modifiedby;
  String? unitPrice;
  String? commissionrate;
  String? taxclass;
  String? usageunit;
  String? qtyPerUnit;
  String? qtyinstock;
  String? reorderlevel;
  String? assignedUserId;
  String? qtyindemand;
  String? imagename;
  String? description;
  String? costPrice;
  String? margin;
  String? productDataSheet;
  String? make;
  String? model;
  String? maintenanceTime;
  String? serviceInterval;
  String? productService;
  String? supplierCode;
  String? installTime;
  String? location;
  String? securityGrade;
  String? productAmps;
  String? cf844;
  String? cf846;
  String? cf848;
  String? productSpecification;
  String? productsTitle;
  String? productRef;
  String? productMaintenanceTime;
  String? productType;
  String? productBarcode;
  String? productZonedItem;
  String? productPowSupplyBattery;
  String? productSounderIndicator;
  String? productControlEquipment;
  String? productNssKeyholderForm;
  String? productSecurityAgreeForm;
  String? productPoliceAppForm;
  String? productDirectDebitForm;
  String? productDescriptionLock;
  String? proShortDescription;
  String? productTypeOfBattery;
  String? productNoOfBatteries;
  String? productSystemTypes;
  String? productManufacturer;
  String? productProdCategory;
  String? id;
  int? quantity;
  bool? isItemAdded;
  List<String>? locationList;

  Result(
      {this.productname,
        this.productNo,
        this.productcode,
        this.discontinued,
        this.salesStartDate,
        this.salesEndDate,
        this.startDate,
        this.expiryDate,
        this.website,
        this.vendorId,
        this.mfrPartNo,
        this.vendorPartNo,
        this.serialNo,
        this.productsheet,
        this.glacct,
        this.createdtime,
        this.modifiedtime,
        this.modifiedby,
        this.unitPrice,
        this.commissionrate,
        this.taxclass,
        this.usageunit,
        this.qtyPerUnit,
        this.qtyinstock,
        this.reorderlevel,
        this.assignedUserId,
        this.qtyindemand,
        this.imagename,
        this.description,
        this.costPrice,
        this.margin,
        this.productDataSheet,
        this.make,
        this.model,
        this.maintenanceTime,
        this.serviceInterval,
        this.productService,
        this.supplierCode,
        this.installTime,
        this.location,
        this.securityGrade,
        this.productAmps,
        this.cf844,
        this.cf846,
        this.cf848,
        this.productSpecification,
        this.productsTitle,
        this.productRef,
        this.productMaintenanceTime,
        this.productType,
        this.productBarcode,
        this.productZonedItem,
        this.productPowSupplyBattery,
        this.productSounderIndicator,
        this.productControlEquipment,
        this.productNssKeyholderForm,
        this.productSecurityAgreeForm,
        this.productPoliceAppForm,
        this.productDirectDebitForm,
        this.productDescriptionLock,
        this.proShortDescription,
        this.productTypeOfBattery,
        this.productNoOfBatteries,
        this.productSystemTypes,
        this.productManufacturer,
        this.productProdCategory,
        this.id,
        this.quantity,
        this.isItemAdded,
        this.locationList = const []});

  Result.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    productNo = json['product_no'];
    productcode = json['productcode'];
    discontinued = json['discontinued'];
    salesStartDate = json['sales_start_date'];
    salesEndDate = json['sales_end_date'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    website = json['website'];
    vendorId = json['vendor_id'];
    mfrPartNo = json['mfr_part_no'];
    vendorPartNo = json['vendor_part_no'];
    serialNo = json['serial_no'];
    productsheet = json['productsheet'];
    glacct = json['glacct'];
    createdtime = json['createdtime'];
    modifiedtime = json['modifiedtime'];
    modifiedby = json['modifiedby'];
    unitPrice = json['unit_price'];
    commissionrate = json['commissionrate'];
    taxclass = json['taxclass'];
    usageunit = json['usageunit'];
    qtyPerUnit = json['qty_per_unit'];
    qtyinstock = json['qtyinstock'];
    reorderlevel = json['reorderlevel'];
    assignedUserId = json['assigned_user_id'];
    qtyindemand = json['qtyindemand'];
    imagename = json['imagename'];
    description = json['description'];
    costPrice = json['cost_price'];
    margin = json['margin'];
    productDataSheet = json['product_data_sheet'];
    make = json['make'];
    model = json['model'];
    maintenanceTime = json['maintenance_time'];
    serviceInterval = json['service_interval'];
    productService = json['product_service'];
    supplierCode = json['supplier_code'];
    installTime = json['install_time'];
    location = json['location'];
    securityGrade = json['security_grade'];
    productAmps = json['product_amps'];
    cf844 = json['cf_844'];
    cf846 = json['cf_846'];
    cf848 = json['cf_848'];
    productSpecification = json['product_specification'];
    productsTitle = json['products_title'];
    productRef = json['product_ref'];
    productMaintenanceTime = json['product_maintenance_time'];
    productType = json['product_type'];
    productBarcode = json['product_barcode'];
    productZonedItem = json['product_zoned_item'];
    productPowSupplyBattery = json['product_pow_supply_battery'];
    productSounderIndicator = json['product_sounder_indicator'];
    productControlEquipment = json['product_control_equipment'];
    productNssKeyholderForm = json['product_nss_keyholder_form'];
    productSecurityAgreeForm = json['product_security_agree_form'];
    productPoliceAppForm = json['product_police_app_form'];
    productDirectDebitForm = json['product_direct_debit_form'];
    productDescriptionLock = json['product_description_lock'];
    proShortDescription = json['pro_short_description'];
    productTypeOfBattery = json['product_type_of_battery'];
    productNoOfBatteries = json['product_no_of_batteries'];
    productSystemTypes = json['product_system_types'];
    productManufacturer = json['product_manufacturer'];
    productProdCategory = json['product_prod_category'];
    id = json['id'];
    quantity = json['quantity'] ?? 1;
    isItemAdded = json['isItemAdded'];
    locationList = json['locationList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productname'] = productname;
    data['product_no'] = productNo;
    data['productcode'] = productcode;
    data['discontinued'] = discontinued;
    data['sales_start_date'] = salesStartDate;
    data['sales_end_date'] = salesEndDate;
    data['start_date'] = startDate;
    data['expiry_date'] = expiryDate;
    data['website'] = website;
    data['vendor_id'] = vendorId;
    data['mfr_part_no'] = mfrPartNo;
    data['vendor_part_no'] = vendorPartNo;
    data['serial_no'] = serialNo;
    data['productsheet'] = productsheet;
    data['glacct'] = glacct;
    data['createdtime'] = createdtime;
    data['modifiedtime'] = modifiedtime;
    data['modifiedby'] = modifiedby;
    data['unit_price'] = unitPrice;
    data['commissionrate'] = commissionrate;
    data['taxclass'] = taxclass;
    data['usageunit'] = usageunit;
    data['qty_per_unit'] = qtyPerUnit;
    data['qtyinstock'] = qtyinstock;
    data['reorderlevel'] = reorderlevel;
    data['assigned_user_id'] = assignedUserId;
    data['qtyindemand'] = qtyindemand;
    data['imagename'] = imagename;
    data['description'] = description;
    data['cost_price'] = costPrice;
    data['margin'] = margin;
    data['product_data_sheet'] = productDataSheet;
    data['make'] = make;
    data['model'] = model;
    data['maintenance_time'] = maintenanceTime;
    data['service_interval'] = serviceInterval;
    data['product_service'] = productService;
    data['supplier_code'] = supplierCode;
    data['install_time'] = installTime;
    data['location'] = location;
    data['security_grade'] = securityGrade;
    data['product_amps'] = productAmps;
    data['cf_844'] = cf844;
    data['cf_846'] = cf846;
    data['cf_848'] = cf848;
    data['product_specification'] = productSpecification;
    data['products_title'] = productsTitle;
    data['product_ref'] = productRef;
    data['product_maintenance_time'] = productMaintenanceTime;
    data['product_type'] = productType;
    data['product_barcode'] = productBarcode;
    data['product_zoned_item'] = productZonedItem;
    data['product_pow_supply_battery'] = productPowSupplyBattery;
    data['product_sounder_indicator'] = productSounderIndicator;
    data['product_control_equipment'] = productControlEquipment;
    data['product_nss_keyholder_form'] = productNssKeyholderForm;
    data['product_security_agree_form'] = productSecurityAgreeForm;
    data['product_police_app_form'] = productPoliceAppForm;
    data['product_direct_debit_form'] = productDirectDebitForm;
    data['product_description_lock'] = productDescriptionLock;
    data['pro_short_description'] = proShortDescription;
    data['product_type_of_battery'] = productTypeOfBattery;
    data['product_no_of_batteries'] = productNoOfBatteries;
    data['product_system_types'] = productSystemTypes;
    data['product_manufacturer'] = productManufacturer;
    data['product_prod_category'] = productProdCategory;
    data['id'] = id;
    data['quantity'] = quantity;
    data['isItemAdded'] = isItemAdded;
    data['locationList'] = locationList;
    return data;
  }
}