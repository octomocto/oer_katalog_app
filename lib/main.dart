import 'package:flutter/material.dart';

import 'util/data_loader.dart';
import 'view/home_screen.dart';
import 'view/splash_screen.dart';
import 'model/oer.dart';

void main() {
  runApp(const OERApp());
}

class OERApp extends StatefulWidget {
  const OERApp({super.key});

  @override
  State<OERApp> createState() => _OERAppState();
}

class _OERAppState extends State<OERApp> {


  @override
  void initState() {
    super.initState();
    _loadHomeScreen();
  }

  Future<Widget>? _loadHomeScreen() async {
    Future<List<OER>> oers = loadOERs();
    Future<Map<String, Map<String, List<String>>>> content = loadContent();
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    var oersLoaded = await oers;
    var contentLoaded = await content;
    return HomeScreen(oers: oersLoaded, content: contentLoaded);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OER',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder<Widget>(
          future: _loadHomeScreen(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const SplashScreen();
            }
          }), //TagSearchView(oers: oers),
    );
  }
}

