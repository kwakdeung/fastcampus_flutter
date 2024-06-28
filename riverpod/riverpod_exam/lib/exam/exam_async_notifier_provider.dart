import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final String name;

  const Product(this.name);
}

Future<List<Product>> fetchProducts() async {
  await Future.delayed(const Duration(seconds: 2));
  // api 처리, 값을 받아오고 처리한 후, return으로 반환하지만,
  // 여기선 값을 받아왔다 치고, List String 객체를 반환만.
  return [
    Product("Product 1"),
    Product("Product 2"),
    Product("Product 3"),
  ];
}

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    try {
      List<Product> products = await fetchProducts();
      return products;
    } catch (e) {
      rethrow;
    }
  }
}

final productProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(
    () => ProductNotifier());

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: productList.when(
          data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(products[index].name)),
              ),
          error: (error, stackTrace) => Text("Error $error"),
          loading: () => const CircularProgressIndicator()),
    );
  }
}
