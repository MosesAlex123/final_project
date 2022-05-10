import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/models/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
@TimestampConverter()
class Product {
  // Product's variables: name, price, imageUrl. All required.
  String name;
  double price;
  String imageUrl;
  int quantity;
  DateTime date;
  String docId;
  String uploaderId;
  String uploaderEmail;

  Product(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.date,
      required this.docId,
      required this.uploaderId,
      required this.uploaderEmail});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // static const List<Product> products = [
  //   Product(
  //       name: 'Apple',
  //       price: 2.99,
  //       imageUrl:
  //           'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80'),
  //   Product(
  //       name: 'Orange',
  //       price: 2.99,
  //       imageUrl:
  //           'https://images.unsplash.com/photo-1547514701-42782101795e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
  //   Product(
  //       name: 'Pear',
  //       price: 2.99,
  //       imageUrl:
  //           'https://images.unsplash.com/photo-1548199569-3e1c6aa8f469?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=638&q=80'),
  // ];
}

final usersQuery = FirebaseFirestore.instance
    .collection('users')
    .orderBy('name')
    .withConverter<Product>(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

/**FirestoreListView<Product>(
  query: usersQuery,
  itemBuilder: (context, snapshot) {
    // Data is now typed!
    Product user = snapshot.data();

    return Text(user.name);
  },
);*/
