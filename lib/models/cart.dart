class CartItem {
  int? productId;
  String? productName;
  double? price;
  int? quantity;
  bool? inStock;

  CartItem({
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.inStock,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    inStock = json['in_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['in_stock'] = inStock;
    return data;
  }
}
