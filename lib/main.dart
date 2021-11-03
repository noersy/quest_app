import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_app/provider/mainscreen_providers.dart';
import 'package:quest_app/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardsSetsProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => TypesFormatsProviders(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Quest App",
        home: SplashScreenPage(),
      ),
    );
  }
}
