import 'package:flutter/material.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/typography_style.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext ctx;
  final String title;

  const AppBarBack({Key? key, required this.ctx, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 0,
        backgroundColor: PaletteColor.primarybg2,
        leading: IconButton(
          onPressed: () => Navigator.of(ctx).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: PaletteColor.primary,
          ),
        ),
        title: Text(
          title,
          style: TypographyStyle.subtitle1,
        ),
      ),
    );
  }
}
