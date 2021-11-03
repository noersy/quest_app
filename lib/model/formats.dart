// To parse this JSON data, do
//
//     final formats = formatsFromJson(jsonString);

import 'dart:convert';

Formats formatsFromJson(String str) => Formats.fromJson(json.decode(str));

String formatsToJson(Formats data) => json.encode(data.toJson());

class Formats {
  Formats({
    required this.formats,
  });

  final List<String>? formats;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    formats: List<String>.from(json["formats"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "formats": List<dynamic>.from(formats!.map((x) => x)),
  };
}
