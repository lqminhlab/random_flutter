import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'extensions/hex_color.dart';
import 'widgets/widget_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Random Flutter",
      theme: ThemeData(
        primaryColor: HexColor.fromHex("#532AF5"),
        fontFamily: "AbrilFatface",
        brightness: Brightness.light,
        buttonTheme: Theme.of(context)
            .buttonTheme
            .copyWith(colorScheme: ColorScheme.light()),
      ),
      home: HomeScreen(),
    );
  }
}
