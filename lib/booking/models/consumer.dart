
import 'package:json_annotation/json_annotation.dart';
part 'consumer.g.dart';

@JsonSerializable()
class Consumer {
  String omang;
  String name;
  String email;
  String phoneNumber;
  String physicalAddress;
  

  Consumer({
    required this.omang,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.physicalAddress,
    
});



  factory Consumer.fromJson(Map<String, dynamic> json) => _$ConsumerFromJson(json);
  Map<String, dynamic> toJson() => _$ConsumerToJson(this);
}

