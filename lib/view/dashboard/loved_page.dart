import 'package:flutter/material.dart';
import 'package:quest_app/component/Indicator/indicator_load.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/model/cards.dart';
import 'package:quest_app/route/route_transisition.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cards/detailedcard_page.dart';

class LovedPage extends StatefulWidget {
  final Cards data;

  const LovedPage({Key? key, required this.data}) : super(key: key);

  @override
  State<LovedPage> createState() => _LovedPageState();
}

class _LovedPageState extends State<LovedPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  Future<SharedPreferences> _getPref() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarBack(title: 'Loved Cards', ctx: context),
      body: FutureBuilder<SharedPreferences>(
          future: _getPref(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: indicatorLoad()),
                ),
              );
            }
            return Scrollbar(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.data.cards.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> _card = widget.data.cards[index];
                  bool _loved = prefs.getBool(
                          "card-" + widget.data
                              .cards[index]["number"]) ?? false;

                  return _loved ? ListTile(
                    onTap: () async {
                      Navigator.of(context).push(
                        routeTransition(DetailedCardPage(
                          card: widget.data.cards[index],
                          prefs: snapshot.data!,
                        )),
                      );
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
                  ) : const SizedBox.shrink();
                },
              ),
            );
          }),
    );
  }
}
