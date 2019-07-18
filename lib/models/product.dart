
class Product {
  final int id;
  final String name;
  final String price;

  Product({this.id, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'],
        name: json['name'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'price': price,
      };
}