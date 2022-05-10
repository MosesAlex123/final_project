import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/catalogue/models/custom_date_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservations.g.dart';

@JsonSerializable()
@TimestampConverter()
class Reservation {
  final String productName;
  final String docId;
  final String reserverEmail;
  final String uploaderId;
  final double price;
  final String prodId;
  final int quantity;
  final DateTime dateTime;

  Reservation(
      {required this.productName,
      required this.quantity,
      required this.dateTime,
      required this.docId,
      required this.reserverEmail,
      required this.price,
      required this.uploaderId,
      required this.prodId});

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
