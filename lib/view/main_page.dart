import 'dart:math';

import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_app/component/Indicator/indicator_load.dart';
import 'package:quest_app/component/appbar/main_appbar.dart';
import 'package:quest_app/model/cards.dart';
import 'package:quest_app/model/formats.dart';
import 'package:quest_app/model/sets.dart';
import 'package:quest_app/model/types.dart';
import 'package:quest_app/provider/mainscreen_providers.dart';
import 'package:quest_app/route/route_transisition.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:quest_app/theme/typography_style.dart';
import 'package:quest_app/view/dashboard/cards/cards_page.dart';
import 'package:quest_app/view/dashboard/cards/detailedcard_page.dart';
import 'package:quest_app/view/dashboard/formats_page.dart';
import 'package:quest_app/view/dashboard/loved_page.dart';
import 'package:quest_app/view/dashboard/sets_page.dart';
import 'package:quest_app/view/dashboard/types_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2.withOpacity(0.94),
      appBar: const MainAppBar(),
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<CardsSetsProviders>(context).getAllData(),
          Provider.of<TypesFormatsProviders>(context).getAllData(),
        ]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(child: indicatorLoad()),
              ),
            );
          }
          return Consumer2<CardsSetsProviders, TypesFormatsProviders>(
            builder: (BuildContext context, value, value2, Widget? child) {
              return MainPageScreen(
                cards: value.cards!,
                sets: value.sets!,
                types: value2.types!,
                formats: value2.formats!,
              );
            },
          );
        },
      ),
    );
  }
}

class MainPageScreen extends StatefulWidget {
  final Cards cards;
  final Sets sets;

  final Types types;
  final Formats formats;

  const MainPageScreen({
    Key? key,
    required this.cards,
    required this.sets,
    required this.types,
    required this.formats,
  }) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final Random random = Random();

  final PageController _controller = PageController();
  final _controllerText = TextEditingController();
  String search = "";
  late List<Map<String, dynamic>> _result;

  final EdgeInsets _insets = const EdgeInsets.only(
    top: SpacingDimens.spacing12,
    left: SpacingDimens.spacing12,
    right: SpacingDimens.spacing12,
  );

  BoxDecoration _containerDecoration() => BoxDecoration(
          color: PaletteColor.primarybg2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 5),
                color: PaletteColor.grey80.withOpacity(0.2))
          ]);

  TextStyle _textStyle() => TextStyle(
        shadows: [
          Shadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: PaletteColor.grey80.withOpacity(0.2),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: SpacingDimens.spacing16,
          ),
          Container(
            margin: _insets.copyWith(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            decoration: _containerDecoration(),
            child: TextFormField(
              cursorColor: PaletteColor.primary,
              style: TypographyStyle.subtitle1,
              controller: _controllerText,
              onChanged: (String? val) {
                setState(() {
                  search = val!;
                });
                _result = widget.cards.cards
                    .where((element) => element["name"]
                        .toLowerCase()
                        .contains(_controllerText.text.toLowerCase()))
                    .toList();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Padding(
                  padding: const EdgeInsets.all(SpacingDimens.spacing8),
                  child: DecoratedIcon(
                    Icons.search,
                    color: PaletteColor.primary,
                    shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                        color: PaletteColor.primary.withOpacity(0.2),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          search.isNotEmpty
              ? SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _result.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _listTileCards(_result.elementAt(index));
                    },
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: _insets,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buttonTop(
                              label: "Cards",
                              icon: Icons.card_travel_rounded,
                              color: PaletteColor.grey80,
                              ctx: context,
                              target: CardsPage(data: widget.cards)),
                          _buttonTop(
                            label: "Sets",
                            icon: Icons.style_outlined,
                            color: PaletteColor.blue,
                            ctx: context,
                            target: SetsPage(data: widget.sets),
                          ),
                          _buttonTop(
                            label: "Types",
                            icon: Icons.all_inbox_outlined,
                            color: PaletteColor.green,
                            ctx: context,
                            target: TypesPage(data: widget.types),
                          ),
                          _buttonTop(
                            label: "Formats",
                            icon: Icons.workspaces_outline,
                            color: PaletteColor.yellow,
                            ctx: context,
                            target: FormatsPage(data: widget.formats),
                          ),
                          _buttonTop(
                            label: "Favorite",
                            icon: Icons.favorite_outlined,
                            color: Colors.pink,
                            ctx: context,
                            target: LovedPage(data: widget.cards),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing28,
                        right: SpacingDimens.spacing28,
                        top: SpacingDimens.spacing24,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cards",
                            style: TypographyStyle.title.merge(
                              _textStyle().copyWith(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              routeTransition(CardsPage(data: widget.cards)),
                            ),
                            child: Text(
                              "View All",
                              style: TypographyStyle.caption1
                                  .merge(_textStyle().copyWith(
                                color: PaletteColor.grey80,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        top: SpacingDimens.spacing8,
                        bottom: SpacingDimens.spacing12,
                      ),
                      child: SizedBox(
                        height: 270,
                        child: PageView.builder(
                          itemCount: 6,
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (v) {
                            if (v >= 5) {
                              _controller.animateTo(
                                1,
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 900),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context, int index) {
                            int cardNum =
                                random.nextInt(widget.cards.cards.length);
                            return _cardList(cardNum, context);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: SpacingDimens.spacing16)
                  ],
                ),
        ],
      ),
    );
  }

  GestureDetector _cardList(number, ctx) {
    var _card = widget.cards.cards[number];

    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Navigator.of(ctx).push(
          routeTransition(DetailedCardPage(
            card: _card,
            prefs: prefs,
          )),
        );
      },
      child: Container(
        decoration: _containerDecoration(),
        padding: const EdgeInsets.only(
          left: SpacingDimens.spacing16 - 4,
          top: SpacingDimens.spacing12,
        ),
        margin: const EdgeInsets.only(
          right: SpacingDimens.spacing8,
          left: SpacingDimens.spacing8,
          bottom: SpacingDimens.spacing12,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SpacingDimens.spacing8,
                  ),
                  child: SizedBox(
                    height: 24,
                    width: 145,
                    child: Center(
                      child: Text(
                        _card["name"],
                        style: TypographyStyle.subtitle2.merge(_textStyle()),
                      ),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: _containerDecoration().copyWith(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                            color: PaletteColor.grey.withOpacity(0.2)),
                      ]),
                  child: SizedBox(
                    height: 200,
                    width: 145,
                    child: _card['imageUrl'] != null
                        ? Image.network(_card['imageUrl'])
                        : Center(
                            child: Text(
                              "no available",
                              style: TypographyStyle.paragraph.merge(
                                _textStyle(),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: SpacingDimens.spacing8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "#${_card['number']}",
                          style: TypographyStyle.paragraph.merge(_textStyle()),
                        ),
                        const SizedBox(height: SpacingDimens.spacing8),
                        Text(
                          "${_card["set"] + " " + _card["setName"]}",
                          style: TypographyStyle.paragraph.merge(_textStyle()),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Rarity : ${_card["rarity"]}",
                          style: TypographyStyle.mini.merge(_textStyle()),
                        ),
                        const SizedBox(height: SpacingDimens.spacing8),
                        Text(
                          "Mana Cost : ${_card["manaCost"]}",
                          style: TypographyStyle.mini.merge(_textStyle()),
                        ),
                        const SizedBox(height: SpacingDimens.spacing8),
                        Text(
                          "Type : ${_card["types"]}",
                          style: TypographyStyle.mini.merge(_textStyle()),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '"${_card['text']}"',
                        style: TypographyStyle.mini.merge(_textStyle()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buttonTop({
    required String label,
    required IconData icon,
    required Color color,
    required target,
    required ctx,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(ctx).push(
          routeTransition(target),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: _containerDecoration(),
            height: 50,
            width: 50,
            child: Center(
              child: DecoratedIcon(
                icon,
                color: color,
                size: 30,
                shadows: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                    color: color.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SpacingDimens.spacing4),
          Text(
            label,
            style: TypographyStyle.button2.merge(_textStyle()),
          ),
        ],
      ),
    );
  }

  ListTile _listTileCards(Map<String, dynamic> _card) {
    return ListTile(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Navigator.of(context).push(routeTransition(DetailedCardPage(
          card: _card,
          prefs: prefs,
        )));
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
  }
}
