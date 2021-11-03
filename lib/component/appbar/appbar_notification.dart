import 'package:flutter/material.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/route/route_transisition.dart';
import 'package:quest_app/theme/palette_color.dart';
import 'package:quest_app/theme/typography_style.dart';

class AppBarNotification extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext ctx;
  final String title;
  final int idStudent;

  const AppBarNotification(
      {Key? key,
      required this.ctx,
      required this.title,
      required this.idStudent})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: PaletteColor.primarybg,
        title: Text(
          title,
          style: TypographyStyle.subtitle1,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
            ),
            color: PaletteColor.primary,
            iconSize: 20,
            onPressed: () {
              Navigator.of(ctx).push(
                routeTransition(Scaffold(
                  appBar: AppBarBack(
                    title: "Notif",
                    ctx: context,
                  ),
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}
