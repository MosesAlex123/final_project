import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/booking/models/farmer.dart';
import 'package:final_project/catalogue/models/cust_product.dart';
import 'package:final_project/views/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:final_project/catalogue/controllers/cart_controller.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:get/get.dart';

import '../../booking/models/consumer.dart';
import '../models/reservations.dart';
import '../../booking/models/factory.dart' as chicken_factory;

class CartProducts extends StatelessWidget {
  final CartController controller = Get.find();
  final String entryPoint;

  CartProducts({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = (entryPoint == "Farmer")
        ? "farmers"
        : (entryPoint == "Consumer")
            ? "consumers"
            : "factories";
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                userType: userType,
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
                //user: controller.getCurrentUser().toString(),
                //formKey: key,
              );
            }),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  final String userType;

  const CartProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index,
      required this.userType
      //required this.formKey
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference reservations =
        FirebaseFirestore.instance.collection('reservations');

    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userType);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              product.imageUrl,
            ),
            child: Text(product.name),
          ),

          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
                '${product.date.day}/${product.date.month}/${product.date.year}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Price: ${product.price * quantity}',
            ),
          ),
          IconButton(
            onPressed: () {
              controller.removeProduct(product);
            },
            icon: const Icon(Icons.remove_circle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$quantity',
            ),
          ),
          IconButton(
            onPressed: () {
              controller.addProduct(product);
            },
            icon: const Icon(Icons.add_circle),
          ),

          //Expanded(child: Text('total products: ${product.quantity}')),

          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              String? userName;

              if (userType == "farmers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Farmer>(
                        fromFirestore: ((snapshot, _) =>
                            Farmer.fromJson(snapshot.data()!)),
                        toFirestore: (farmer, _) => farmer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else if (userType == "consumers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Consumer>(
                        fromFirestore: ((snapshot, _) =>
                            Consumer.fromJson(snapshot.data()!)),
                        toFirestore: (consumer, _) => consumer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<chicken_factory.Factory>(
                        fromFirestore: ((snapshot, _) =>
                            chicken_factory.Factory.fromJson(snapshot.data()!)),
                        toFirestore: (factory, _) => factory.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              }

              Get.snackbar(
                "Booking: ${product.name}",
                "Quantity: $quantity  Price: ${product.price}",
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 5),
              );

              //controller.updateProduct(product);
              FirebaseFirestore.instance
                  .collection('Farmer products')
                  .doc(
                      product.docId) // <-- Doc ID where data should be updated.
                  .update({'quantity': product.quantity}) // <-- Updated data
                  .then((_) => print('Updated'))
                  .catchError((error) => print('Update failed: $error'));

              DocumentReference reserve =
                  FirebaseFirestore.instance.collection('reservations').doc();
              reserve
                  .set({
                    'quantity': quantity + 1,
                    'price': product.price * quantity,
                    'dateTime': product.date,
                    'productName': product.name,
                    'uploaderId': product.uploaderId,
                    'reserverEmail': FirebaseAuth.instance.currentUser!.email!,
                    'docId': reserve.id,
                    'prodId': product.docId
                  })
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AuthGate()))))
                  .catchError((error) {
                    if (kDebugMode) {
                      print('Failed to add Product: $error');
                    }
                  });
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }
}

class ConsumerProducts extends StatelessWidget {
  final CustCartController controller = Get.find();
  final String entryPoint;

  ConsumerProducts({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userType = (entryPoint == "Farmer")
        ? "farmers"
        : (entryPoint == "Consumer")
            ? "consumers"
            : "factories";
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: controller.custProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return ConsumerProductCard(
                userType: userType,
                controller: controller,
                product: controller.custProducts.keys.toList()[index],
                quantity: controller.custProducts.values.toList()[index],
                index: index,
                //user: controller.getCurrentUser().toString(),
                //formKey: key,
              );
            }),
      ),
    );
  }
}

class ConsumerProductCard extends StatelessWidget {
  final CustCartController controller;
  final CustProduct product;
  final int quantity;
  final int index;
  final String userType;

  const ConsumerProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index,
      required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userType);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              product.imageUrl,
            ),
            child: Text(product.uploaderEmail),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child:
                Text('${product.name}\nTotalPrice:${product.price * quantity}'),
          ),

          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
                '${product.date.day}/${product.date.month}/${product.date.year}'),
          ),
          IconButton(
            onPressed: () {
              controller.removeProduct(product);
            },
            icon: const Icon(Icons.remove_circle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$quantity',
            ),
          ),
          IconButton(
            onPressed: () {
              controller.addProduct(product);
            },
            icon: const Icon(Icons.add_circle),
          ),

          //Expanded(child: Text('total products: ${product.quantity}')),

          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              String? userName;

              if (userType == "farmers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Farmer>(
                        fromFirestore: ((snapshot, _) =>
                            Farmer.fromJson(snapshot.data()!)),
                        toFirestore: (farmer, _) => farmer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else if (userType == "consumers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Consumer>(
                        fromFirestore: ((snapshot, _) =>
                            Consumer.fromJson(snapshot.data()!)),
                        toFirestore: (consumer, _) => consumer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<chicken_factory.Factory>(
                        fromFirestore: ((snapshot, _) =>
                            chicken_factory.Factory.fromJson(snapshot.data()!)),
                        toFirestore: (factory, _) => factory.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saving Booking'),
                ),
              );

              var collection =
                  FirebaseFirestore.instance.collection('farmer products');
              collection
                  .doc('docId') // <-- Doc ID where data should be updated.
                  .update({'quantity': product.quantity}) // <-- Updated data
                  .then((_) => print('Updated'))
                  .catchError((error) => print('Update failed: $error'));

              DocumentReference reserve =
                  FirebaseFirestore.instance.collection('reservations').doc();
              reserve
                  .set({
                    'quantity': quantity,
                    'dateTime': product.date,
                    'productName': product.name,
                    'uploaderId': product.uploaderId,
                    'reserverEmail': FirebaseAuth.instance.currentUser!.email!,
                    'docId': reserve.id
                  })
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AuthGate()))))
                  .catchError((error) => print('Failed to add User: $error'));
            },
            child: const Text('Book'),
          ),
        ],
      ),
      /**ElevatedButton(
            onPressed: () {
              String? userName;

              if (userType == "farmers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Farmer>(
                        fromFirestore: ((snapshot, _) =>
                            Farmer.fromJson(snapshot.data()!)),
                        toFirestore: (farmer, _) => farmer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else if (userType == "consumers") {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<Consumer>(
                        fromFirestore: ((snapshot, _) =>
                            Consumer.fromJson(snapshot.data()!)),
                        toFirestore: (consumer, _) => consumer.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              } else {
                userCollection
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .withConverter<chicken_factory.Factory>(
                        fromFirestore: ((snapshot, _) =>
                            chicken_factory.Factory.fromJson(snapshot.data()!)),
                        toFirestore: (factory, _) => factory.toJson())
                    .get()
                    .then((value) {
                  userName = value.data()!.name;
                });
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saving Booking'),
                ),
              );
              DocumentReference items = FirebaseFirestore.instance
                          .collection('Farmer products')
                          .doc();
                      items
                          .set({
                            'name': name,
                            'quantity': quantity,
                            'price': price,
                            'imageUrl': imageUrl,
                            'date': selectedDate,
                            'docId': items.id,
                            'uploaderId': FirebaseAuth.instance.currentUser!.uid,
                            'uploaderEmail': FirebaseAuth.instance.currentUser!.email
                          })
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const FarmerNav()))))
                          .catchError(
                              (error) => print('Failed to add User: $error'));
              var reservation = Reservation(
                  quantity: quantity,
                  dateTime: product.date,
                  productName: product.name,
                  uploaderId: product.uploaderId,
                  reserverEmail: FirebaseAuth.instance.currentUser!.email!,
                  docId: FirebaseAuth.instance.currentUser!.email!);

              var collection =
                  FirebaseFirestore.instance.collection('farmer products');
              collection
                  .doc('docId') // <-- Doc ID where data should be updated.
                  .update({'quantity': product.quantity}) // <-- Updated data
                  .then((_) => print('Updated'))
                  .catchError((error) => print('Update failed: $error'));

              reservations
                  .add(reservation.toJson())
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AuthGate()))))
                  .catchError((error) {
                if (kDebugMode) {
                  print('Failed to add Product: $error');
                }
              });
            },
            child: const Text('Book'),
          ),*/
    );
  }
}
