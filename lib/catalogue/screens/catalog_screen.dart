import 'package:final_project/views/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:final_project/catalogue/screens/cart_screen.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  final String entryPoint;
  const CatalogScreen({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalogue"),
        backgroundColor: Colors.blueGrey,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const AuthGate())));
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CatalogProducts(),
            ElevatedButton(
              onPressed: () => Get.to(() => CartScreen(entryPoint: entryPoint)),
              child: Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsumerCatalog extends StatelessWidget {
  final String entryPoint;
  const ConsumerCatalog({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consumer Catalog")),
      body: SafeArea(
        child: Column(
          children: [
            CatalogProducts(),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => ConsumerCartScreen(entryPoint: entryPoint)),
              child: const Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
