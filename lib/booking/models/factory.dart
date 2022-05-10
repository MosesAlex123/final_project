
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'factory.g.dart';

@JsonSerializable()
class Factory {
  String businessID;
  String name;
  String email;
  String phoneNumber;
  String physicalAddress;

  Factory({
    required this.businessID,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.physicalAddress,
});


  factory Factory.fromJson(Map<String, dynamic> json) => _$FactoryFromJson(json);
  Map<String, dynamic> toJson() => _$FactoryToJson(this);
}

