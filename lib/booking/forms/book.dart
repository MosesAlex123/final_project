import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/controllers/cart_controller.dart';
import 'package:final_project/catalogue/controllers/product_controller.dart';
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:final_project/views/auth_gate.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordPS extends StatelessWidget {
  final String entryPoint;
  const RecordPS({Key? key, required this.entryPoint}) : super(key: key);

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
          RecordP(
            entrypoint: entryPoint,
          ),
        ],
      ),
    );
  }
}

class RecordP extends StatelessWidget {
  final controller = Get.put(ReservationController());
  final ReservationController reserve = Get.find();
  final productController = Get.put(ProductController());
  String entrypoint;

  RecordP({Key? key, required this.entrypoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 600,
        child: ListView.builder(
            itemCount: controller.reservation.length,
            itemBuilder: (BuildContext context, int index) {
              //if (entrypoint == reserve.reservation[index].uploaderId) {
              return RecordProduct(
                //controller: controller,
                userId: reserve.reservation[index].uploaderId,
                index: index,
                product: productController.products.toList()[index],
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

class RecordProduct extends StatelessWidget {
  final controller = Get.put(ReserverController());
  final ReservationController reserve = Get.find();
  final ProductController productController = Get.find();
  Product product;
  //final Reservation reserve;
  final String userId;
  final int index;

  RecordProduct(
      {Key? key,
      //required this.controller,
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
            child: Text('${reserve.reservation[index].quantity}'),
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
          content: const Text('Are you sure you want to delete booking?'),
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
                          reserve.reservation[index].quantity +
                              product.quantity -
                              1
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

class ConsumerBook extends StatefulWidget {
  const ConsumerBook({ Key? key }) : super(key: key);

  @override
  State<ConsumerBook> createState() => _ConsumerBookState();
}

class _ConsumerBookState extends State<ConsumerBook> {
  final productQuery = FirebaseFirestore.instance
      .collection('consumer reservations')
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
          backgroundColor: Color.fromARGB(0, 53, 18, 18),
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to delete booking?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                FirebaseFirestore.instance
                    .collection('reservations')
                    .doc('reserverEmail')
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