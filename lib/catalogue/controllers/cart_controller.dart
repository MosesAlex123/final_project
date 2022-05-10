import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/controllers/product_controller.dart';
import 'package:final_project/catalogue/models/cust_product.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:final_project/catalogue/models/reservations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // Add a dict to store the products in the cart.
  final _products = {}.obs;
  late Rx<User> firebaseUser;

  void addProduct(Product product) {
    // var value = product.quantity - 1;
    if (_products.containsKey(product)) {
      _products[product] += 1;
      product.quantity--;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added: ${product.quantity} remaining",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product)) {
      _products.removeWhere((key, value) => key == product);
      product.quantity++;
    } else {
      _products[product] -= 1;
    }

    Get.snackbar(
      "Product Removed",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  void updateProduct(Product product) {
    var collection = FirebaseFirestore.instance.collection('factory products');
    collection
        .doc('docId') // <-- Doc ID where data should be updated.
        .update({'quantity': product.quantity}) // <-- Updated data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }

  get user => _products;

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  get quantity => _products.entries
      .map((product) => product.key.quantity)
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);
}

class CustCartController extends GetxController {
  // Add a dict to store the products in the cart.
  final _products = {}.obs;

  void addProduct(CustProduct product) {
    // var value = product.quantity - 1;
    if (_products.containsKey(product)) {
      _products[product] += 1;
      product.quantity--;
    } else {
      _products[product] = 1;
    }

    Get.snackbar(
      "Product Added: ${product.quantity} remaining",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void removeProduct(CustProduct product) {
    if (_products.containsKey(product)) {
      _products.removeWhere((key, value) => key == product);
      product.quantity++;
    } else {
      _products[product] -= 1;
    }

    Get.snackbar(
      "Product Removed:  ${product.quantity} remaining",
      "You have added the ${product.name} to the cart",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  get custProducts => _products;

  get reserve => _products;
}

class ReserverController extends GetxController {
  // Add a dict to store the products in the cart.
  final _reserves = {}.obs;

  void removeReservation() {
    if (_reserves.containsKey(reserve)) {
      _reserves.removeWhere((key, value) => key == reserve);
      FirebaseFirestore.instance
          .collection('reservations')
          .doc('docId')
          .delete()
          .then(
            (doc) => print("Reservation deleted"),
            onError: (e) => print("Error updating document $e"),
          );
    }

    Get.snackbar(
      "Product Removed: remaining",
      "You have added the to the cart",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  get reserve => _reserves;
}
