import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tuple/tuple.dart';

import '../model/oer.dart';

import 'oer_tile.dart';

class TagSearchView extends StatefulWidget {
  final List<OER> oers;

  const TagSearchView({Key? key, required this.oers}) : super(key: key);

  @override
  State<TagSearchView> createState() => _TagSearchViewState();
}

class _TagSearchViewState extends State<TagSearchView> {
  String query = "";
  List<Level> selectedLevels = [];
  List<Medium> selectedMedia = [];
  List<Subject> selectedSubjects = [];
  List<StatisticalSoftware> selectedStatisticalSoftware = [];
  List<Language> selectedLanguages = [];
  bool licenceSelected = false;
  bool interactivitySelected = false;
  bool exercisesSelected = false;
  bool visualisationSelected = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildSearchBar() {
    Widget filters = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(height: 35),
          Row(
            children: [
              Text("Freie Schlagwortsuche: "),
              Expanded(
                child: TextFormField(
                  onChanged: (String? val) {
                    setState(() {
                      query = val!;
                    });
                  },
                  decoration:
                      const InputDecoration(suffixIcon: Icon(Icons.search)),
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("Schwierigkeitsniveau: "),
              Expanded(
                child: DropDownMultiSelect<String>(
                  onChanged: (List<String> list) {
                    setState(() {
                      selectedLevels =
                          list.map((level) => Level.fromString(level)!).toList();
                    });
                  },
                  options: Level.values
                      .map((level) => Level.asString(level)!)
                      .toList(),
                  selectedValues: selectedLevels
                      .map((level) => Level.asString(level)!)
                      .toList(),
                  whenEmpty: 'Wählen..',
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("Medien: "),
              Expanded(
                  child: DropDownMultiSelect<String>(
                onChanged: (List<String> list) {
                  setState(() {
                    selectedMedia =
                        list.map((medium) => Medium.fromString(medium)!).toList();
                  });
                },
                options: Medium.values
                    .map((medium) => Medium.asString(medium)!)
                    .toList(),
                selectedValues: selectedMedia
                    .map((medium) => Medium.asString(medium)!)
                    .toList(),
                whenEmpty: 'Wählen...',
              ))
            ],
          ),
          Row(children: [
            Text("Fachbezug: "),
            Expanded(
                child: DropDownMultiSelect<String>(
              onChanged: (List<String> list) {
                setState(() {
                  selectedSubjects = list
                      .map((subject) => Subject.fromString(subject)!)
                      .toList();
                });
              },
              options: Subject.values
                  .map((subject) => Subject.asString(subject))
                  .toList(),
              selectedValues: selectedSubjects
                  .map((subject) => Subject.asString(subject))
                  .toList(),
              whenEmpty: 'Wählen...',
            ))
          ]),
          Row(children: [
            Text("Statistiksoftware: "),
            Expanded(
                child: DropDownMultiSelect<String>(
                    onChanged: (List<String> list) {
                      setState(() {
                        selectedStatisticalSoftware = list
                            .map((statisticalSoftware) =>
                                StatisticalSoftware.fromString(
                                    statisticalSoftware)!)
                            .toList();
                      });
                    },
                    options: StatisticalSoftware.values
                        .map((statisticalSoftware) =>
                            StatisticalSoftware.asString(statisticalSoftware))
                        .toList(),
                    selectedValues: selectedStatisticalSoftware
                        .map((statisticalSoftware) =>
                            StatisticalSoftware.asString(statisticalSoftware))
                        .toList(),
                    whenEmpty: 'Wählen...'))
          ]),
          Row(children: [
            Text("Sprache: "),
            Expanded(
                child: DropDownMultiSelect<String>(
                    onChanged: (List<String> list) {
                      setState(() {
                        selectedLanguages = list
                            .map((language) => Language.fromString(language)!)
                            .toList();
                      });
                    },
                    options: Language.values
                        .map((e) => Language.asString(e)!)
                        .toList(),
                    selectedValues: selectedLanguages
                        .map((language) => Language.asString(language)!)
                        .toList(),
                    whenEmpty: 'Wählen...'))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("Lizenz: "),
            Checkbox(
                value: licenceSelected,
                onChanged: (bool? x) {
                  setState(() {
                    licenceSelected = x!;
                  });
                }),
            Text("Interaktive Lerninhalte: "),
            Checkbox(
              value: interactivitySelected,
              onChanged: (bool? x) {
                setState(() {
                  interactivitySelected = x!;
                });
              },
            ),
            Text("Übungsaufgaben: "),
            Checkbox(
              value: exercisesSelected,
              onChanged: (bool? x) {
                setState(() {
                  exercisesSelected = x!;
                });
              },
            ),
            Text("Visualisierungen: "),
            Checkbox(
              value: visualisationSelected,
              onChanged: (bool? x) {
                setState(() {
                  visualisationSelected = x!;
                });
              },
            )
          ]),
        ],
      ),
    );
    return filters;
  }

  bool hasMatch(List<dynamic> selectedList, List<dynamic> oerValues) {
    for (dynamic value in oerValues) {
      if (selectedList.contains(value)) {
        return true;
      }
    }
    return false;
  }

  // Filter
  List<OER> filterOERs() {
    List<OER> filter = [];

    Map<List<dynamic>, dynamic> selectedFilters = {
      selectedLevels: (oer) => oer.levels,
      selectedMedia: (oer) => oer.media,
      selectedSubjects: (oer) => [oer.subject], // obacht: braucht Liste
      selectedStatisticalSoftware: (oer) => [oer.statisticalSoftware],
      selectedLanguages: (oer) => oer.languages
    };

    List<Tuple2<bool, dynamic>> applyCheckboxes = [
      Tuple2(licenceSelected, (oer) => oer.licence),
      Tuple2(interactivitySelected, (oer) => oer.interactivity),
      Tuple2(exercisesSelected, (oer) => oer.exercises),
      Tuple2(visualisationSelected, (oer) => oer.visualisation)
    ];

    // For-Schleife für Filter
    for (OER oer in widget.oers) {
      for (dynamic selected in selectedFilters.keys) {
        if (selected.isNotEmpty) {
          if (!hasMatch(selected, selectedFilters[selected](oer))) {
            filter.add(oer);
          }
        }
      }
      for (Tuple2 selected in applyCheckboxes) {
        if (selected.item1) {
          if (!selected.item2(oer)) {
            filter.add(oer);
          }
        }
      }
      if (query != "") {
        if (!oer.name.contains(query) && !oer.name.contains(query.substring(0, 1).toUpperCase() + query.substring(1))) {
          filter.add(oer);
        }
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

  Widget buildGridView() {
    List<Widget> children = [];

    List<OER> filteredOERS = filterOERs();

    for (OER oer in filteredOERS) {
      OERTile oerTile = OERTile(oer: oer);
      children.add(oerTile);
    }

    GridView gridView = GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: children,
    );
    return gridView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()), title: Text("Freie Suche"), centerTitle: true,),
        body: Column(
      children: [
        Expanded(flex: 3, child: buildSearchBar()),
        Expanded(flex: 2, child: buildGridView()),
      ],
    ));
  }
}
