// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consumer _$ConsumerFromJson(Map<String, dynamic> json) => Consumer(
      omang: json['omang'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      physicalAddress: json['physicalAddress'] as String,
    );

Map<String, dynamic> _$ConsumerToJson(Consumer instance) => <String, dynamic>{
      'omang': instance.omang,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'physicalAddress': instance.physicalAddress,
    };
