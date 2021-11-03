// To parse this JSON data, do
//
//     final types = typesFromJson(jsonString);

import 'dart:convert';

Types typesFromJson(String? str) => Types.fromJson(json.decode(str!));

String typesToJson(Types? data) => json.encode(data!.toJson());

class Types {
  Types({
    required this.types,
  });

  final List<String>? types;

  factory Types.fromJson(Map<String, dynamic> json) => Types(
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "types": List<dynamic>.from(types!.map((x) => x)),
  };
}
