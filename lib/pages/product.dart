import 'package:flutter/material.dart';
import 'package:tugasakhir/api/product_services.dart';
import 'package:tugasakhir/model/product_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Page')),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Products Found'));
          } else {
            var products = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(
                      int.parse('0xff' + products[index].color.substring(1))),
                  child: Center(
                    child:
                        Text(products[index].name, textAlign: TextAlign.center),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
