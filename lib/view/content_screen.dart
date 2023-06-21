import 'package:flutter/material.dart';

import '../model/oer.dart';
import 'oer_tile.dart';

class ContentScreen extends StatefulWidget {
  final List<OER> oers;
  final Map<String, Map<String, List<String>>> content;

  const ContentScreen({Key? key, required this.oers, required this.content}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  Set<String> selectedTags = {};
  String titleSelected = "";
  String subtitleSelected = "";

  @override
  void initState() {
    super.initState();
  }

  bool hasMatch(Set<dynamic> selectedList, List<dynamic> oerValues) {
    for (dynamic value in oerValues) {
      if (selectedList.contains(value)) {
        return true;
      }
    }
    return false;
  }

  List<OER> filterOERs() {
    List<OER> filter = [];

    // For-Schleife für Filter
    for (OER oer in widget.oers) {
      if (selectedTags.isNotEmpty) {
        if (!hasMatch(selectedTags, oer.tags)) {
          filter.add(oer);
        }
      } else {
        filter.add(oer);
      }
    }

    List<OER> result = [];
    for (OER oer in widget.oers) {
      if (!filter.contains(oer)) {
        result.add(oer);
      }
    }
    return result;
  }

  List<Widget> buildOERTiles() {
    List<Widget> result = [];
    for (OER oer in filterOERs()) {
      result.add(OERTile(oer: oer));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Inhaltsverzeichnis"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: createExpansionTile(widget.content)),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: buildOERTiles(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> createExpansionTile(Map<String, Map<String, List<String>>> content) {
    List<Widget> result = [];

    for (String keyTitle in content.keys) {
      List<Widget> listTilesTags = [];
      List<Widget> listExpansionTilesSubtitles = [];

      for (String keySubtitle in content[keyTitle]!.keys) {
        var tags = content[keyTitle]![keySubtitle];
        listTilesTags = tags!
            .map((String tag) => ListTile(
                  title: Text(tag),
                  trailing: Checkbox(
                      value: selectedTags.contains(tag),
                      onChanged: (bool? checked) {
                        setState(() {
                          if (checked!) {
                            selectedTags.add(tag);
                          } else {
                            selectedTags.remove(tag);
                          }
                        });
                      }),
                ))
            .toList();

        //Subtitle
        Widget subtitleExpansionTile = Visibility(
          visible: subtitleSelected == "" || subtitleSelected == keySubtitle,
          child: ExpansionTile(
              title: Text(keySubtitle, style: const TextStyle(fontStyle: FontStyle.italic)),
              children: listTilesTags,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  if (expanded) {
                    subtitleSelected = keySubtitle;
                    selectedTags = tags.toSet();
                  } else {
                    subtitleSelected = "";
                    selectedTags = content[keyTitle]!.keys.toSet();
                  }
                });
              }),
        );
        listExpansionTilesSubtitles.add(subtitleExpansionTile);
      }

      //Title
      Widget titleExpansionTile = Visibility(
        visible: titleSelected == "" || titleSelected == keyTitle,
        child: ExpansionTile(
          title: Text(
            keyTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: listExpansionTilesSubtitles,
          onExpansionChanged: (bool expanded) {
            setState(() {
              if (expanded) {
                titleSelected = keyTitle;
                selectedTags = content[keyTitle]!.keys.toSet();
              } else {
                titleSelected = "";
                subtitleSelected = "";
                selectedTags = {};
              }
            });
          },
        ),
      );
      result.add(titleExpansionTile);
    }

    return result;
  }
}
