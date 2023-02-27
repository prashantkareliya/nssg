
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
  String? selectLocation;


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
    String? selectLocation
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
      selectLocation: selectLocation ?? this.selectLocation
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
      this.quantity, this.selectLocation});

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
    selectLocation = json['selectLocation'];
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
    data['selectLocation'] = selectLocation;
    return data;
  }
}

