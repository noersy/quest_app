import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quest_app/theme/palette_color.dart';

Widget indicatorLoad() {
  return const SpinKitPouringHourGlass(
    size: 45,
    color: PaletteColor.black,
  );
}
