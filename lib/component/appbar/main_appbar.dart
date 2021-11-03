import 'package:flutter/material.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/spacing_dimens.dart';
import 'package:quest_app/theme/typography_style.dart';

class MainAppBar extends StatelessWidget implements PreferredSize {

  const MainAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: PaletteColor.primarybg2.withOpacity(0),
      title: Padding(
        padding: const EdgeInsets.only(top: SpacingDimens.spacing16),
        child: Text(
          "Quest",
          style: TypographyStyle.title.merge(const TextStyle(
            fontFamily: 'BLKCHCRY',
            fontSize: 36,
          )),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(
            right: SpacingDimens.spacing12,
            top: SpacingDimens.spacing16,
          ),
          child: Icon(
            Icons.power_settings_new_rounded,
            color: PaletteColor.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}
