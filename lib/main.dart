import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_demo/workflow/home/home_screen_widget.dart';
import 'package:news_app_demo/workflow/home_model/country.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CountryDataAdapter());
  Hive.registerAdapter(CountryAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsScreenWidget(),
    );
  }
}
