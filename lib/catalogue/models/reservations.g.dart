// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      dateTime:
          const TimestampConverter().fromJson(json['dateTime'] as Timestamp),
      docId: json['docId'] as String,
      reserverEmail: json['reserverEmail'] as String,
      price: (json['price'] as num).toDouble(),
      uploaderId: json['uploaderId'] as String,
      prodId: json['prodId'] as String,
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'docId': instance.docId,
      'reserverEmail': instance.reserverEmail,
      'uploaderId': instance.uploaderId,
      'price': instance.price,
      'prodId': instance.prodId,
      'quantity': instance.quantity,
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
    };
