import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/models/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cust_product.g.dart';

@JsonSerializable()
@TimestampConverter()
class CustProduct {
  // Product's variables: name, price, imageUrl. All required.
  String name;
  double price;
  String imageUrl;
  int quantity;
  DateTime date;
  String docId;
  String uploaderId;
  String uploaderEmail;

  CustProduct(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.date,required this.docId,
      required this.uploaderId,
      required this.uploaderEmail});

  factory CustProduct.fromJson(Map<String, dynamic> json) =>
      _$CustProductFromJson(json);

  Map<String, dynamic> toJson() => _$CustProductToJson(this);
}
