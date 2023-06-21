import 'package:flutter/material.dart';

import '../model/oer.dart';

import 'profile_screen.dart';
import 'tag_search_view.dart';
import 'content_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<OER> oers;
  final Map<String, Map<String, List<String>>> content;

  const HomeScreen({Key? key, required this.oers, required this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String cardA_title = "Inhaltsverzeichnis";
  String cardA_text = "Der gesamte OER-Katalog auf einen Blick.";
  dynamic cardA_icon = Icons.assignment;

  String cardB_title = "Freie Suche";
  String cardB_text = "Suche und filter nach geeigneten Lernmaterialien.";
  dynamic cardB_icon = Icons.search_rounded;

  String cardC_title = "Lernprofil erstellen";
  String cardC_text = "Finde passende Lernmaterialien für dich.";
  dynamic cardC_icon = Icons.face_4;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(height: 35),
      SizedBox(
        width: 1000,
        child: Column(children: [
          const Text('OER-Katalog', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
          Container(height: 10),
          const Text('Frei verfügbare Lernmaterialien aus dem Bereich \nquantitative Forschungsmethoden & Statistik',
              textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          Container(height: 50),
          const Text(
              'Diese App hilft dir, Open Educational Resources (OER) schnell und unkompliziert zu finden. Der Katalog umfasst eine Vielzahl unterschiedlicher Lernmaterialien aus dem Bereich quantitative Forschungsmethoden und Statistik, die du kostenlos nutzen und direkt über den Browser öffnen kannst. Jede*r kann diese App nutzen, auch wenn die Inhalte vorrangig auf Studierende der Sozialwissenschaften, Pädagogik und Psychologie ausgerichtet sind. Dir stehen drei Suchmöglichkeiten zur Verfügung:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25)),
        ]),
      ),
      Container(height: 35),
      _buildCard(
          cardA_icon, cardA_title, cardA_text, (context) => ContentScreen(oers: widget.oers, content: widget.content)),
      _buildCard(cardB_icon, cardB_title, cardB_text, (context) => TagSearchView(oers: widget.oers)),
      _buildCard(
          cardC_icon, cardC_title, cardC_text, (context) => const ProfileScreen())
    ])));
  }

  Widget _buildCard(dynamic icon, String title, String text, dynamic screenBuilder) {
    return GestureDetector(
        onTap: () {
          _navigateToDifferentScreen(screenBuilder /*(context) => TagSearchView(oers: widget.oers)*/);
        },
        child: SizedBox(
            height: 150,
            width: 600,
            child: Card(
                color: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Add an image widget to display an image
                          Icon(
                            icon, //format list bullet
                            //weight: 100,
                            size: 50,
                          ),
                          // Add some spacing between the image and the text
                          Container(width: 20),
                          // Add an expanded widget to take up the remaining horizontal space
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Add some spacing between the top of the card and the title
                              Container(height: 5),
                              // Add a title widget
                              Text(title,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
                              // Add some spacing between the title and the subtitle
                              Container(height: 5),
                              // Add a subtitle widget
                              Text(text, style: TextStyle(fontSize: 20, color: Colors.grey[500])),
                              // Add some spacing between the subtitle and the text
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                ))));
  }

  _navigateToDifferentScreen(dynamic screenBuilder) {
    Navigator.push(context, MaterialPageRoute(builder: screenBuilder));
  }
}
