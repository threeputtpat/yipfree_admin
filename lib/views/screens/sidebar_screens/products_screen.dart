import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen ({super.key});

  static const String routeName = '/ProductsScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Products',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      );
    }
}