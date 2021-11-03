import 'package:flutter/material.dart';
import 'package:quest_app/component/appbar/appbar_back.dart';
import 'package:quest_app/model/formats.dart';
import 'package:quest_app/theme/palette_color.dart';

class FormatsPage extends StatelessWidget {
  final Formats data;

  const FormatsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarBack(ctx: context, title: "Formats"),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.formats!.length,
        itemBuilder: (BuildContext context, int index) {
          String _format = data.formats![index];
          return ListTile(
            title: Text(_format),
          );
        },
      ),
    );
  }
}
