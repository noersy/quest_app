// To parse this JSON data, do
//
//     final sets = setsFromJson(jsonString);

import 'dart:convert';

Sets setsFromJson(String str) => Sets.fromJson(json.decode(str));

String setsToJson(Sets data) => json.encode(data.toJson());

class Sets {
  Sets({
    required this.sets,
  });

  final List<Set> sets;

  factory Sets.fromJson(Map<String, dynamic> json) => Sets(
    sets: List<Set>.from(json["sets"].map((x) => Set.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sets": List<dynamic>.from(sets.map((x) => x.toJson())),
  };
}

class Set {
  Set({
    required this.code,
    required this.name,
    required this.type,
    required this.booster,
    required this.releaseDate,
    required this.block,
    required this.onlineOnly,
  });

  final String? code;
  final String? name;
  final Type? type;
  final List<dynamic>? booster;
  final DateTime? releaseDate;
  final String? block;
  final bool? onlineOnly;

  factory Set.fromJson(Map<String, dynamic> json) => Set(
    code: json["code"],
    name: json["name"],
    type: typeValues.map[json["type"]],
    booster: json["booster"] == null ? null : List<dynamic>.from(json["booster"].map((x) => x)),
    releaseDate: DateTime.parse(json["releaseDate"]),
    block: json["block"] ?? " ",
    onlineOnly: json["onlineOnly"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "type": typeValues.reverse[type],
    "booster": booster == null ? null : List<dynamic>.from(booster!.map((x) => x)),
    "releaseDate": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "block": block,
    "onlineOnly": onlineOnly,
  };
}

enum PurpleBooster { RARE, MYTHIC_RARE }

final purpleBoosterValues = EnumValues({
  "mythic rare": PurpleBooster.MYTHIC_RARE,
  "rare": PurpleBooster.RARE
});

enum FluffyBooster { RARE, UNCOMMON, COMMON }

final fluffyBoosterValues = EnumValues({
  "common": FluffyBooster.COMMON,
  "rare": FluffyBooster.RARE,
  "uncommon": FluffyBooster.UNCOMMON
});

enum Type { CORE, MASTERS, EXPANSION, MEMORABILIA, COMMANDER, STARTER, TOKEN, ARCHENEMY, BOX, DRAFT_INNOVATION, FROM_THE_VAULT, FUNNY, DUEL_DECK, MASTERPIECE, PROMO, PREMIUM_DECK, PLANECHASE, VANGUARD, TREASURE_CHEST }

final typeValues = EnumValues({
  "archenemy": Type.ARCHENEMY,
  "box": Type.BOX,
  "commander": Type.COMMANDER,
  "core": Type.CORE,
  "draft_innovation": Type.DRAFT_INNOVATION,
  "duel_deck": Type.DUEL_DECK,
  "expansion": Type.EXPANSION,
  "from_the_vault": Type.FROM_THE_VAULT,
  "funny": Type.FUNNY,
  "masterpiece": Type.MASTERPIECE,
  "masters": Type.MASTERS,
  "memorabilia": Type.MEMORABILIA,
  "planechase": Type.PLANECHASE,
  "premium_deck": Type.PREMIUM_DECK,
  "promo": Type.PROMO,
  "starter": Type.STARTER,
  "token": Type.TOKEN,
  "treasure_chest": Type.TREASURE_CHEST,
  "vanguard": Type.VANGUARD
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
