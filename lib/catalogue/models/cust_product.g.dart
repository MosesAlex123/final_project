// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cust_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustProduct _$CustProductFromJson(Map<String, dynamic> json) => CustProduct(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as int,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      docId: json['docId'] as String,
      uploaderId: json['uploaderId'] as String,
      uploaderEmail: json['uploaderEmail'] as String,
    );

Map<String, dynamic> _$CustProductToJson(CustProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'date': const TimestampConverter().toJson(instance.date),
      'docId': instance.docId,
      'uploaderId': instance.uploaderId,
      'uploaderEmail': instance.uploaderEmail,
    };
