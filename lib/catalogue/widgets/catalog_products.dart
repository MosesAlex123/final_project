import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/catalogue/controllers/product_controller.dart';
import 'package:get/get.dart';

import 'package:final_project/catalogue/controllers/cart_controller.dart';

class CatalogProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(
                index: index,
              );
            }),
      ),
    );
  }
}

class CatalogProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final ProductController productController = Get.find();
  final int index;

  CatalogProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                productController.products[index].imageUrl,
              ),
              child: Text(productController.products[index].name)),
          SizedBox(width: 40),
          Expanded(
            child: Text(
              productController.products[index].uploaderEmail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Text('${productController.products[index].price}'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '${productController.products[index].date.day}/${productController.products[index].date.month}/${productController.products[index].date.year}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            '${productController.products[index].quantity}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )),
          IconButton(
            onPressed: () {
              cartController.addProduct(productController.products[index]);
            },
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ],
      ),
    );
  }

  void addProd(ProductController prod) {}
}

class CustCatalogProducts extends StatelessWidget {
  final productController = Get.put(ProductController());

  CustCatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductCard(index: index);
            }),
      ),
    );
  }
}

class CustCatalogProductCard extends StatelessWidget {
  final cartController = Get.put(CustCartController());
  final CustProductController productController = Get.find();
  final int index;

  CustCatalogProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              productController.products[index].imageUrl,
            ),
            child: Text(productController.products[index].name),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Text(
              productController.products[index].uploaderEmail,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text('${productController.products[index].price}'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '${productController.products[index].date.day}/${productController.products[index].date.month}/${productController.products[index].date.year}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            '${productController.products[index].quantity}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )),
          IconButton(
            onPressed: () {
              cartController.addProduct(productController.products[index]);
            },
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ],
      ),
    );
  }
}
