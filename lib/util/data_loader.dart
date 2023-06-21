import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import 'package:excel/excel.dart';

import '../model/oer.dart';
import '../util/constants.dart';

bool convertStringToBool(String string) {
  string = string.trim();
  if (string == Constants.yesSign) {
    return true;
  }
  if (string == Constants.noSign) {
    return false;
  }
  throw Exception("Invalid string input: $string");
}

// OER laden (xlsx)
Future<List<OER>> loadOERs() async {
  List<OER> result = []; // List.empty(growable: true);

  String oerFilePath = 'data/oers_collection.xlsx';
  ByteData data = await rootBundle.load(oerFilePath);
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);

  var oerData = excel.tables["OERs"]!;

  int rowIndex = 0;
  for (var row in oerData.rows) {
    rowIndex++;
    if (rowIndex < 4) {
      continue;
    }

    String name = row[0]!.value.toString();
    String provider = row[1]!.value.toString();
    String url = row[2]!.value.toString();
    List<String> tags = row[3]!.value.toString().split("; ");
    List<String> levels = row[4]!.value.toString().split("; ");
    List<String> mediums = row[5]!.value.toString().split("; ");
    String license = row[6]!.value.toString();
    String subject = row[7]!.value.toString();
    String statisticalSoftware = row[8]!.value.toString();
    String interactivity = row[9]!.value.toString();
    String exercises = row[10]!.value.toString();
    String visualisation = row[11]!.value.toString();
    List<String> languages = row[12]!.value.toString().split("; ");
    String information = row[13]!.value.toString();

    OER oer = OER(
        name,
        provider,
        url,
        tags,
        levels.map((level) => Level.fromString(level)!).toList(),
        mediums.map((medium) => Medium.fromString(medium)!).toList(),
        convertStringToBool(license),
        Subject.fromString(subject)!,
        StatisticalSoftware.fromString(statisticalSoftware)!,
        convertStringToBool(interactivity),
        convertStringToBool(exercises),
        convertStringToBool(visualisation),
        languages.map((language) => Language.fromString(language)!).toList(),
        information);

    result.add(oer);
  }
  if (kDebugMode) {
    print(result);
  }

  return Future(() => result);
}

// Inhaltsverzeichnis laden (txt)
Future<Map<String, Map<String, List<String>>>> loadContent() async {
  Map<String, Map<String, List<String>>> result = {};

  String inhaltsverzeichnisFilePath = 'data/inhaltsverzeichnis_raw.txt';
  String content =  await rootBundle.loadString(inhaltsverzeichnisFilePath);
  List<String> contentLines = content.split("\n");

  String keyTitle = "";
  String keySubtitle = "";
  for (String row in contentLines) {
    if (row.contains(">")) {
      result[row.substring(1).trim()] = {}; // Map<String, List<String>>
      keyTitle = row.substring(1).trim();
    }
    if (row.contains("-")) {
      result[keyTitle]![row.substring(1).trim()] = []; // List<String>
      keySubtitle = row.substring(1).trim();
    }
    if (row.contains("*")) {
      result[keyTitle]![keySubtitle]!
          .add(row.substring(1).trim()); // add String to List
    }
  }

  return Future(() => result);
}
