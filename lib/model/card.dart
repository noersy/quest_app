// To parse this JSON data, do
//
//     final card = cardFromJson(jsonString);

import 'dart:convert';

CardModel cardFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    required this.card,
  });

  final CardClass card;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    card: CardClass.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "card": card.toJson(),
  };
}

class CardClass {
  CardClass({
    required this.name,
    required this.manaCost,
    required this.cmc,
    required this.type,
    required this.types,
    required this.rarity,
    required this.cardSet,
    required this.setName,
    required this.text,
    required this.artist,
    required this.number,
    required this.layout,
    required this.multiverseid,
    required this.imageUrl,
    required this.rulings,
    required this.printings,
    required this.originalText,
    required this.originalType,
    required this.legalities,
    required this.id,
  });

  final String name;
  final String manaCost;
  final int cmc;
  final String type;
  final List<String> types;
  final String rarity;
  final String cardSet;
  final String setName;
  final String text;
  final String artist;
  final String number;
  final String layout;
  final String multiverseid;
  final String imageUrl;
  final List<Ruling> rulings;
  final List<String> printings;
  final String originalText;
  final String originalType;
  final List<Legality> legalities;
  final String id;

  factory CardClass.fromJson(Map<String, dynamic> json) => CardClass(
    name: json["name"],
    manaCost: json["manaCost"],
    cmc: json["cmc"],
    type: json["type"],
    types: List<String>.from(json["types"].map((x) => x)),
    rarity: json["rarity"],
    cardSet: json["set"],
    setName: json["setName"],
    text: json["text"],
    artist: json["artist"],
    number: json["number"],
    layout: json["layout"],
    multiverseid: json["multiverseid"],
    imageUrl: json["imageUrl"],
    rulings: List<Ruling>.from(json["rulings"].map((x) => Ruling.fromJson(x))),
    printings: List<String>.from(json["printings"].map((x) => x)),
    originalText: json["originalText"],
    originalType: json["originalType"],
    legalities: List<Legality>.from(json["legalities"].map((x) => Legality.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "manaCost": manaCost,
    "cmc": cmc,
    "type": type,
    "types": List<dynamic>.from(types.map((x) => x)),
    "rarity": rarity,
    "set": cardSet,
    "setName": setName,
    "text": text,
    "artist": artist,
    "number": number,
    "layout": layout,
    "multiverseid": multiverseid,
    "imageUrl": imageUrl,
    "rulings": List<dynamic>.from(rulings.map((x) => x.toJson())),
    "printings": List<dynamic>.from(printings.map((x) => x)),
    "originalText": originalText,
    "originalType": originalType,
    "legalities": List<dynamic>.from(legalities.map((x) => x.toJson())),
    "id": id,
  };
}

class Legality {
  Legality({
    required this.format,
    required this.legality,
  });

  final String format;
  final String legality;

  factory Legality.fromJson(Map<String, dynamic> json) => Legality(
    format: json["format"],
    legality: json["legality"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "legality": legality,
  };
}

class Ruling {
  Ruling({
    required this.date,
    required this.text,
  });

  final DateTime date;
  final String text;

  factory Ruling.fromJson(Map<String, dynamic> json) => Ruling(
    date: DateTime.parse(json["date"]),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "text": text,
  };
}
