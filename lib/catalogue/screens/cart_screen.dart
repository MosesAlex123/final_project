import 'package:final_project/catalogue/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  final String entryPoint;
  const CartScreen({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.blueGrey,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => CatalogScreen(entryPoint: entryPoint,))));
          },
        ),
      ),
      body: Column(
        children: [
          CartProducts(entryPoint: entryPoint),
        ],
      ),
    );
  }
}

class ConsumerCartScreen extends StatelessWidget {
  final String entryPoint;
  const ConsumerCartScreen({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consumer Cart")),
      body: Column(
        children: [
          ConsumerProducts(entryPoint: entryPoint),
        ],
      ),
    );
  }
}
