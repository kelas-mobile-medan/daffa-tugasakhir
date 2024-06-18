// ignore_for_file: type_init_formals

import 'package:flutter/material.dart';
import 'package:tugasakhir/pages/login.dart';
import 'package:tugasakhir/pages/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  final String username;
  const Home({super.key, required String this.username});

  @override
  Widget build(BuildContext context) {
    removeSessionLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('is_login');
    }

    var listItem = [
      'List Item 1',
      'List Item 2',
      'List Item 3',
      'List Item 4',
      'List Item 5',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Text('Ini Halaman Home, Welcome $username'),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Product()));
              },
              child: const Text('Halaman GridView')),
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              removeSessionLogin();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: listItem.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listItem[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
