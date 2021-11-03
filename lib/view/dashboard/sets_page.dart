import 'package:flutter/material.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/model/sets.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:quest_app/theme/typography_style.dart';

class SetsPage extends StatelessWidget {
  final Sets data;

  const SetsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarBack(ctx: context, title: "Sets"),
      body: Scrollbar(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.sets.length,
          itemBuilder: (BuildContext context, int index) {
            Set _set = data.sets[index];

            return ListTile(
              title: Row(
                children: [
                  Flexible(
                    child: Text(_set.name!, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: SpacingDimens.spacing4),
                  Text(
                    _set.code!,
                    style: TypographyStyle.caption1,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(_set.type!.index.toString()),
                  const SizedBox(
                    width: SpacingDimens.spacing4,
                  ),
                  Text(_set.block!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
