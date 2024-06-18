import 'package:flutter/material.dart';
import 'package:tugasakhir/api/product_services.dart';
import 'package:tugasakhir/model/product_model.dart';
import 'package:tugasakhir/pages/login.dart';
import 'package:tugasakhir/pages/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({super.key, required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService.fetchProducts();
  }

  Future<void> removeSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Text('Ini Halaman Home, Welcome ${widget.username}'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Halaman GridView'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () async {
                await removeSessionLogin();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Logout'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
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
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(products[index].name),
                        subtitle:
                            Text('Pantone: ${products[index].pantoneValue}'),
                        tileColor: Color(int.parse(
                            '0xff' + products[index].color.substring(1))),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
