import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    var listItem = [
      'Product 1',
      'Product 2',
      'Product 3',
      'Product 4',
      'Product 5',
      'Product 6',
      'Product 7',
      'Product 8',
      'Product 9',
      'Product 10',
    ];

    return Scaffold(
        appBar: AppBar(title: const Text('Product Page')),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: listItem.length,
            itemBuilder: (context, index) {
              return Card(
                child: Center(
                  child: Text(listItem[index]),
                ),
              );
            }));
  }
}
