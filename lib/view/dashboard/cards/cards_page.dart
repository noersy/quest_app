import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/model/cards.dart';
import 'package:quest_app/route/route_transisition.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:quest_app/view/dashboard/cards/detailedcard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardsPage extends StatelessWidget {
  final Cards data;

  const CardsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarBack(ctx: context, title: "Cards"),
      body: Scrollbar(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.cards.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> _card = data.cards[index];
            return ListTile(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();

                Navigator.of(context).push(
                    routeTransition(DetailedCardPage(card: data.cards[index], prefs: prefs,)));
              },
              leading: _card["imageUrl"] != null
                  ? Image.network(_card["imageUrl"])
                  : const SizedBox(
                      height: 50,
                      width: 40,
                      child: Center(child: Text(" ")),
                    ),
              title: Text(_card["name"]),
              subtitle: Row(
                children: [
                  Text("#${_card["number"] + " " + _card["set"]}"),
                  const SizedBox(
                    width: SpacingDimens.spacing4,
                  ),
                  Text("${_card["rarity"]}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
