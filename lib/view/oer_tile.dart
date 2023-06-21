import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/oer.dart';

class OERTile extends StatefulWidget {
  final OER oer;

  const OERTile({Key? key, required this.oer}) : super(key: key);

  @override
  State<OERTile> createState() => _OERTileState();
}

class _OERTileState extends State<OERTile> {
  final Map<Medium, IconData> iconMap = {
    Medium.text: Icons.book,
    Medium.encyclopaedia: Icons.book,
    Medium.manual: Icons.book,
    Medium.blog: Icons.book,
    Medium.onlineCourse: Icons.book,
    Medium.onlineBook: Icons.book,
    Medium.audio: Icons.audiotrack,
    Medium.video: Icons.video_camera_back_outlined,
    Medium.lectureVideo: Icons.video_camera_back_outlined,
    Medium.teachingMaterial: Icons.description
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OER oer = widget.oer;
    return Container(
        padding: const EdgeInsets.all(8),
        color: Colors.yellow,
        child: ExpansionTile(
          leading: Icon(iconMap[oer.media.first]),
          title: Text(oer.name),
          children: [
            Container(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.levels
                  .map((Level level) => Level.asString(level)!)
                  .toString()),
            ]),
            Container(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb),
                Flexible(
                    //use Flexible to wrap text as text grows
                    child: Text(oer.media
                        .map((Medium media) => Medium.asString(media)!)
                        .toString()))
              ],
            ),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.printLicence(oer.licence))
            ]),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(Subject.asString(oer.subject))
            ]),
            Container(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb),
                Text(StatisticalSoftware.asString(oer.statisticalSoftware))
              ],
            ),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.printInteractivity(oer.interactivity))
            ]),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.printExercises(oer.exercises))
            ]),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.printVisualisation(oer.visualisation))
            ]),
            Container(height: 3),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Icon(Icons.lightbulb),
              Text(oer.languages
                  .map((Language language) => Language.asString(language)!)
                  .toString()),
            ]),
            Container(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _launchUrl(oer.url),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.link),
                    Text('  Lernmaterial öffnen'),
                  ],
                ),
              ), // Funktion asString auf Liste von Levels mappen
            )
          ],
        ));
  }

  Future<void> _launchUrl(String url) async {
    // multithreading
    bool launchSuccessful = await launchUrl(Uri.parse(url));
    if (!launchSuccessful) {
      throw Exception('Could not launch $url');
    }
  }
}
