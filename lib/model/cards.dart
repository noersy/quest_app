import 'dart:convert';


Cards allCardFromJson(String str) => Cards.fromJson(json.decode(str));

class Cards {
  final List<Map<String, dynamic>> cards;

  Cards({required this.cards});

  factory Cards.fromJson(Map<String, dynamic> json){
    return Cards(
      cards: List<Map<String, dynamic>>.from(json["cards"]),
    );
  }
}