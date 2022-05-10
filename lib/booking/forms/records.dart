import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/controllers/cart_controller.dart';
import 'package:final_project/catalogue/controllers/product_controller.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:final_project/catalogue/models/reservations.dart';
import 'package:final_project/views/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

class RecordScreen extends StatelessWidget {
  final String entryPoint;
  const RecordScreen({Key? key, required this.entryPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RECORDS"),
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
      body: Column(
        children: [
          SaveProduct(
            entrypoint: entryPoint,
          ),
        ],
      ),
    );
  }
}

class SaveProduct extends StatelessWidget {
  final controller = Get.put(ReservationController());
  final prodController = Get.put(ProductController());
  final ReservationController reserve = Get.find();
  final ProductController productController = Get.find();
  String entrypoint;

  SaveProduct({Key? key, required this.entrypoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: controller.reservation.length,
            itemBuilder: (BuildContext context, int index) {
              //if (entrypoint == reserve.reservation[index].uploaderId) {
              return SaveProductCard(
                //productController: productController,
                userId: reserve.reservation[index].uploaderId,
                index: index,
                product: productController.products[index],
                //user: controller.getCurrentUser().toString(),
                //formKey: key,
              );
              //} else {
              // return const CircularProgressIndicator();
              //}
            }),
      ),
    );
  }
}

class SaveProductCard extends StatelessWidget {
  final controller = Get.put(ReserverController());
  final ReservationController reserve = Get.find();

  Product product;
  //final Reservation reserve;
  final String userId;
  final int index;

  SaveProductCard(
      {Key? key,
      //required this.productController,
      //required this.reserve,
      required this.userId,
      required this.index,
      required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(reserve.reservation[index].productName),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(reserve.reservation[index].reserverEmail),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
                '${reserve.reservation[index].dateTime.day}/${reserve.reservation[index].dateTime.month}/${reserve.reservation[index].dateTime.year}'),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text('Qty: ${reserve.reservation[index].quantity}'),
          ),
          Expanded(
            child: Text('Price: ${reserve.reservation[index].price}'),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              showBanner(context);
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }

  void showBanner(BuildContext context) =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(10),
          content: const Text(
              'Are you sure you want to cancel booking?\nNOTE: the action is IREVERSABLE'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

                FirebaseFirestore.instance
                    .collection('Farmer products')
                    .doc(reserve.reservation[index]
                        .prodId) // <-- Doc ID where data should be updated.
                    .update({
                      'quantity': //productController.products[index].quantity +
                          reserve.reservation[index].quantity + product.quantity
                    }) // <-- Updated data
                    .then((_) => print('Updated'))
                    .catchError((error) => print('Update failed: $error'));
                FirebaseFirestore.instance
                    .collection('reservations')
                    .doc(reserve.reservation[index].docId)
                    .delete()
                    .then(
                      (doc) => print("Reservation deleted"),
                      onError: (e) => print("Error updating document $e"),
                    );
              },
              child: const Text('YES'),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('NO'))
          ]));
}
/** 
class PrintRecords extends StatefulWidget {
  const PrintRecords({Key? key}) : super(key: key);

  @override
  State<PrintRecords> createState() => _PrintRecordsState();
}

class _PrintRecordsState extends State<PrintRecords> {
  final reserver = FirebaseFirestore.instance
      .collection('reservations')
      .orderBy('productName');
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FactoryReports extends StatefulWidget {
  const FactoryReports({Key? key}) : super(key: key);

  @override
  State<FactoryReports> createState() => _FactoryReportsState();
}

class _FactoryReportsState extends State<FactoryReports> {
  final productQuery = FirebaseFirestore.instance
      .collection('reservations')
      .orderBy('productName');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FirestoreQueryBuilder(
        query: productQuery,
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }

          return ListView.builder(
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              // if we reached the end of the currently obtained items, we try to
              // obtain more items
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }

              final prod = snapshot.docs[index];

              return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text('${prod['productName']}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text('${prod['quantity']}'),
                        ),
                        Expanded(
                          child: Text('${prod['dateTime']}'),
                        ),
                        Expanded(
                          child: Text('${prod['reserverEmail']}'),
                        ),
                        IconButton(
                          onPressed: () {
                            showBanner();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ]));
            },
          );
        },
      )),
    );
  }

  void showBanner() =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to delete booking?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                FirebaseFirestore.instance
                    .collection('consumer reservations')
                    .doc('reserverId')
                    .delete()
                    .then(
                      (doc) => print("Document deleted"),
                      onError: (e) => print("Error updating document $e"),
                    );
              },
              child: const Text('YES'),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('NO'))
          ]));
}
*/