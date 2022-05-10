// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farmer _$FarmerFromJson(Map<String, dynamic> json) => Farmer(
      omang: json['omang'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      physicalAddress: json['physicalAddress'] as String,
    );

Map<String, dynamic> _$FarmerToJson(Farmer instance) => <String, dynamic>{
      'omang': instance.omang,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'physicalAddress': instance.physicalAddress,
    };
