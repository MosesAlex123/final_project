
import 'package:final_project/catalogue/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'farmer.g.dart';

@JsonSerializable()
class Farmer {
  String omang;
  String name;
  String email;
  String phoneNumber;
  String physicalAddress;

  Farmer({
    required this.omang,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.physicalAddress,
});


  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);
  Map<String, dynamic> toJson() => _$FarmerToJson(this);
}

