class ProductsList {
  String? itemName;
  String? costPrice;
  String? sellingPrice;
  String? discountPrice;
  String? amountPrice;
  String? profit;
  int? quantity;

  ProductsList(
      {this.itemName,
      this.costPrice,
      this.sellingPrice,
      this.discountPrice,
      this.amountPrice,
      this.profit,
      this.quantity});

  ProductsList.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    costPrice = json['costPrice'];
    sellingPrice = json['sellingPrice'];
    discountPrice = json['discountPrice'];
    amountPrice = json['amountPrice'];
    profit = json['profit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['costPrice'] = costPrice;
    data['sellingPrice'] = sellingPrice;
    data['discountPrice'] = discountPrice;
    data['amountPrice'] = amountPrice;
    data['profit'] = profit;
    data['quantity'] = quantity;
    return data;
  }
}
