import 'package:nssg/utils/extention_text.dart';

class ProductsList {
  String? itemId;
  String? productId;
  String? itemName;
  String? costPrice;
  String? sellingPrice;
  String? discountPrice;
  String? amountPrice;
  String? profit;
  String? description;
  int? quantity;
  bool? itemAdd;
  String? selectLocation;
  String? titleLocation;
  List<String>? locationList;
  List<String>? titleLocationList;
  String? productImage;
  String? requiredDocument;
  List<String>? requiredDocumentList;

  ProductsList copyWith({
    String? itemId,
    String? productId,
    String? itemName,
    String? costPrice,
    String? sellingPrice,
    String? discountPrice,
    String? amountPrice,
    String? profit,
    String? description,
    int? quantity,
    bool? itemAdd,
    String? selectLocation,
    String? titleLocation,
    List<String>? locationList,
    List<String>? titleLocationList,
    List<String>? requiredDocumentList,
    String? productImage,
    String? requiredDocument
  }) {
    return ProductsList(
        itemId: itemId ?? this.itemId,
        productId: productId ?? this.productId,
        itemName: itemName ?? this.itemName,
        costPrice: costPrice ?? this.costPrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        discountPrice: discountPrice ?? this.discountPrice,
        amountPrice: amountPrice ?? this.amountPrice,
        profit: profit ?? this.profit,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        itemAdd: itemAdd ?? this.itemAdd,
        selectLocation: selectLocation ?? this.selectLocation,
        titleLocation: titleLocation ?? this.titleLocation,
        locationList: locationList ?? this.locationList,
        titleLocationList: titleLocationList ?? this.titleLocationList,
        requiredDocumentList: requiredDocumentList ?? this.requiredDocumentList,
        productImage: productImage ?? this.productImage,
        requiredDocument: productImage ?? this.requiredDocument
    );
  }

  ProductsList(
      {this.itemId,
        this.productId,
        this.itemName,
        this.costPrice,
        this.sellingPrice,
        this.discountPrice,
        this.amountPrice,
        this.profit,
        this.description,
        this.quantity,
        this.itemAdd,
        this.selectLocation,
        this.titleLocation,
        this.locationList = const [],
        this.titleLocationList = const [],
        this.requiredDocumentList = const [],
        this.productImage,
      this.requiredDocument});

  ProductsList.fromJson(Map<String, dynamic> json) {
    itemId = json["itemId"];
    productId = json["productId"];
    itemName = json['itemName'];
    costPrice = json['costPrice'];
    sellingPrice = json['sellingPrice'];
    discountPrice = json['discountPrice'];
    amountPrice = json['amountPrice'];
    profit = json['profit'];
    description = json['description'];
    //quantity = json['quantity'];
    quantity = (json['quantity'] is String) ? int.tryParse(json["quantity"]) : json['quantity'];
//    json['quantity'] is String ? quantity.toString() : quantity = json['quantity'];
    itemAdd = json['itemAdd'];
    selectLocation = json['selectLocation'];
    titleLocation = json['titleLocation'];
    locationList = json['locationList'];
    titleLocationList = json['titleLocationList'];
    requiredDocumentList = json['requiredDocumentList'];
    productImage = json['productImage'];
    requiredDocument = json['requiredDocument'];
  }

  ProductsList.fromJsonOne(Map<String, dynamic> json) {
    itemId = json["parent_id"];
    productId = json["productid"];
    itemName = json['prod_name'];
    costPrice = json['costprice'].toString().formatAmount;
    sellingPrice = json['listprice'].toString().formatAmount;
    discountPrice = json['discount_amount'].toString().formatAmount;
    amountPrice = json['listprice'].toString().formatAmount;
    profit = json['profit'];
    description = json['description'];
    //quantity = json['quantity'];
    quantity = (json['quantity'] is String) ? int.parse(json["quantity"].toString().substring(0,json["quantity"].toString().indexOf("."))) : json['quantity'];
//    json['quantity'] i v vgbfgs String ? quantity.toString() : quantity = json['quantity'];
    itemAdd = json['itemAdd'];
    selectLocation = json['selectLocation'];
    titleLocation = json['titleLocation'];
    locationList = json['locationList'];
    titleLocationList = json['titleLocationList'];
    requiredDocumentList = json['requiredDocumentList'];
    productImage = json['imagename'];
    requiredDocument = json['requiredDocument'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["itemId"] = itemId;
    data["productId"] = productId;
    data['itemName'] = itemName;
    data['costPrice'] = costPrice;
    data['sellingPrice'] = sellingPrice;
    data['discountPrice'] = discountPrice;
    data['amountPrice'] = amountPrice;
    data['profit'] = profit;
    data['description'] = description;
    data['quantity'] = quantity;
    data['itemAdd'] = itemAdd;
    data['selectLocation'] = selectLocation;
    data['titleLocation'] = titleLocation;
    data['locationList'] = locationList;
    data['locationList'] = titleLocationList;
    data['requiredDocumentList'] = requiredDocumentList;
    data['productImage'] = productImage;
    data['requiredDocument'] = requiredDocument;
    return data;
  }
}

