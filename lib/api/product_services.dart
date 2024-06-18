import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugasakhir/model/product_model.dart';

class ProductService {
  static const String url = 'https://reqres.in/api/unknown';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      List<Product> products =
          body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
