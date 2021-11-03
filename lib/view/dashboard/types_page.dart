import 'package:flutter/material.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/model/types.dart';
import 'package:quest_app/theme/palette_color.dart';

class TypesPage extends StatelessWidget {
  final Types data;

  const TypesPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarBack(ctx: context, title: "Types"),
      body: Scrollbar(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.types!.length,
          itemBuilder: (BuildContext context, int index) {
            String _type = data.types![index];

            return ListTile(
              title: Text(_type),
            );
          },
        ),
      ),
    );
  }
}
