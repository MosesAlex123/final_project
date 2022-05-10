import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/models/cust_product.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:final_project/catalogue/models/reservations.dart';
import 'package:final_project/catalogue/services/firestore_db.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // Add a list of Product objects.
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getAllProducts());
    super.onInit();
  }
}
class CustProductController extends GetxController {
  // Add a list of Product objects.
  final products = <CustProduct>[].obs;

  @override
  void onInit() {
    products.bindStream(FirestoreDB().getFactoryProducts());
    super.onInit();
  }
}

class ReservationController extends GetxController {
  // Add a list of Product objects.
  final reservation = <Reservation>[].obs;

  @override
  void onInit() {
    reservation.bindStream(FirestoreDB().getAllReservations());
    super.onInit();
  }
}
