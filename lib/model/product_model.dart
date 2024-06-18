class Product {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;

  Product(
      {required this.id,
      required this.name,
      required this.year,
      required this.color,
      required this.pantoneValue});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
      pantoneValue: json['pantone_value'],
    );
  }
}
