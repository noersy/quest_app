import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:quest_app/theme/typography_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedCardPage extends StatefulWidget {
  final Map<String, dynamic> card;
  final SharedPreferences prefs;

  const DetailedCardPage({Key? key, required this.card, required this.prefs})
      : super(key: key);

  @override
  State<DetailedCardPage> createState() => _DetailedCardPageState();
}

class _DetailedCardPageState extends State<DetailedCardPage> {
  bool _isLoved = false;

  @override
  void initState() {
    setState(() {
      _isLoved = widget.prefs.getBool("card-"+widget.card["number"]) ?? false;
    });
    super.initState();
  }

  _saveLove() async {
    if (_isLoved) {
      setState(() {
        _isLoved = false;
      });
    } else {
      setState(() {
        _isLoved = true;
      });
    }
    await widget.prefs.setBool(("card-"+widget.card["number"]), _isLoved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PaletteColor.primarybg2,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: PaletteColor.primary,
          ),
        ),
        title: Text(
          '${widget.card["name"] + " #" + widget.card["number"]}',
          style: TypographyStyle.subtitle1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingDimens.spacing8),
            // ignore: prefer_const_constructors
            child: GestureDetector(
                onTap: _saveLove,
                child: Icon(
                  _isLoved ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.pink,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing12),
              child: Row(
                children: [
                  SizedBox(
                    height: 200,
                    child: widget.card["imageUrl"] != null
                        ? Image.network(widget.card["imageUrl"])
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("[${widget.card["set"]}] " "${widget.card["setName"]}"),
                          const SizedBox(height: SpacingDimens.spacing4),
                          Text("CMC : ${widget.card["cmc"]}"),
                          Text("Type : ${widget.card["types"]}"),
                          Text("Rarity : ${widget.card["rarity"]}"),
                          Text("Mana Const : ${widget.card["manaCost"]}"),
                          const SizedBox(height: SpacingDimens.spacing4),
                          Text("Artist : ${widget.card["artist"]}"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: SpacingDimens.spacing8),
            Text(
              'Original Type :  ${widget.card["originalType"]}',
              style: TypographyStyle.caption1,
            ),
            const SizedBox(height: SpacingDimens.spacing16),
            const Text("Text", style: TypographyStyle.subtitle2),
            Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing12,
                left: SpacingDimens.spacing24,
                right: SpacingDimens.spacing24,
                bottom: SpacingDimens.spacing12,
              ),
              child: Text('" ${widget.card["text"]} "'),
            ),
            const Text("Original Text", style: TypographyStyle.subtitle2),
            Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing12,
                left: SpacingDimens.spacing24,
                right: SpacingDimens.spacing24,
                bottom: SpacingDimens.spacing12,
              ),
              child: Text('" ${widget.card["originalText"]} "'),
            ),
            const SizedBox(height: SpacingDimens.spacing16),
            widget.card["rulings"] != null
                ? const Text("Rulings", style: TypographyStyle.subtitle2)
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing12,
                left: SpacingDimens.spacing24,
                right: SpacingDimens.spacing24,
              ),
              child: SizedBox(
                height: 250,
                child: widget.card["rulings"] != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.card["rulings"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Text('${widget.card["rulings"][index]["date"]}'),
                              const SizedBox(
                                height: SpacingDimens.spacing4,
                              ),
                              Text(
                                  '" ${widget.card["rulings"][index]["text"]} "'),
                            ],
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Text("ID : ${widget.card["id"]}", style: TypographyStyle.caption1),
            const SizedBox(height: SpacingDimens.spacing16),
          ],
        ),
      ),
    );
  }
}
