class Product {
  String name;
  double price;
  String? description;
  String? imageUrl;
  String? assetPath;

  Product(
    this.name,
    this.price, {
    this.description,
    this.assetPath,
    this.imageUrl,
  });
}
