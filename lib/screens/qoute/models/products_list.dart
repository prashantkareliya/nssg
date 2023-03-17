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
    String? productImage

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
        productImage: productImage ?? this.productImage
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
        this.productImage});

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
    quantity = json['quantity'];
    itemAdd = json['itemAdd'];
    selectLocation = json['selectLocation'];
    titleLocation = json['titleLocation'];
    locationList = json['locationList'];
    titleLocationList = json['titleLocationList'];
    productImage = json['productImage'];
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
    data['productImage'] = productImage;
    return data;
  }
}

