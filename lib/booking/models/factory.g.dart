// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'factory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Factory _$FactoryFromJson(Map<String, dynamic> json) => Factory(
      businessID: json['businessID'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      physicalAddress: json['physicalAddress'] as String,
    );

Map<String, dynamic> _$FactoryToJson(Factory instance) => <String, dynamic>{
      'businessID': instance.businessID,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'physicalAddress': instance.physicalAddress,
    };
