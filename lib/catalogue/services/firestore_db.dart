import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/models/cust_product.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:final_project/catalogue/models/reservations.dart';
import 'package:flutter/foundation.dart';

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('Farmer products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        if (kDebugMode) {
          print('Getting all products: ${doc.data().toString()}');
        }
        return Product.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<CustProduct>> getFactoryProducts() {
    return _firebaseFirestore
        .collection('factory products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        if (kDebugMode) {
          print('Getting all products: ${doc.data().toString()}');
        }
        return CustProduct.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<Reservation>> getAllReservations() {
    return _firebaseFirestore
        .collection('reservations')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        if (kDebugMode) {
          print('Getting all products: ${doc.data().toString()}');
        }
        return Reservation.fromJson(doc.data());
      }).toList();
    });
  }
}
