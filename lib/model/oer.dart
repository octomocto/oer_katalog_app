import '../util/constants.dart';

enum Level {
  beginner,
  medium,
  advanced;

  static Level? fromString(String string) {
    return Constants.levelMap[string];
  }

  static String? asString(Level level) {
    for(String key in Constants.levelMap.keys) {
      if(level == Constants.levelMap[key] ) {
        return key;
      }
    }
    return null;
  }
}

enum Medium {
  text,
  encyclopaedia,
  manual,
  blog,
  onlineBook,
  onlineCourse,
  audio,
  video,
  lectureVideo,
  teachingMaterial;

  static Medium? fromString(String string) {
    switch (string) {
      case "Text":
        return Medium.text;
      case "Lexikon":
        return Medium.encyclopaedia;
      case "Manual":
        return Medium.manual;
      case "Blog":
        return Medium.blog;
      case "online-Buch":
        return Medium.onlineBook;
      case "online-Kurs":
        return Medium.onlineCourse;
      case "Audio":
        return Medium.audio;
      case "Video":
        return Medium.video;
      case "Vorlesungsaufzeichnung":
        return Medium.lectureVideo;
      case "Lehrmaterial Hochschule":
        return Medium.teachingMaterial;
      default:
        return null;
    }
  }

  static String? asString(Medium medium) {
    for (String key in Constants.mediaMap.keys) {
      if(medium == Constants.mediaMap[key]) {
        return key;
      }
    }
    return null;
  }
}

/*enum Licence {
  none,
  by,
  bync,
  bysa,
  byncsa,
  bynd,
  byncnd;

  static Licence? fromString(String string) {
    switch (string) {
      case "-":
        return Licence.none;
      case "CC: Attribution (BY)":
        return Licence.by;
      case "CC: Attribution (BY) - NonCommercial (NC)":
        return Licence.bync;
      case "CC: Attribution (BY) - ShareAlike (SA)":
        return Licence.bysa;
      case "CC: Attribution (BY) - NonCommercial (NC) - ShareAlike (SA)":
        return Licence.byncsa;
      case "CC: Attribution (BY) - NoDerivatives (ND)":
        return Licence.bynd;
      case "CC: Attribution (BY) - NonCommercial (NC) - No Derivatives (ND)":
        return Licence.byncnd;
      default:
        return null;
    }
  }
}*/

enum Subject {
  psychology,
  education,
  sociology,
  politics,
  economics;

  static Subject? fromString(String string) {
    switch (string) {
      case "Psychologie":
        return Subject.psychology;
      case "Bildungs- und Erziehungswissenschaften":
        return Subject.education;
      case "Soziologie":
        return Subject.sociology;
      case "Politikwissenschaften":
        return Subject.politics;
      case "Wirtschaftswissenschaften":
        return Subject.economics;
      default:
        return null;
    }
  }

  static String asString(Subject subject) {
    for(String key in Constants.subjectMap.keys) {
      if(subject == Constants.subjectMap[key]) {
        return key;
      }
    }
    return "keine Angabe";
  }
}

enum StatisticalSoftware {
  none,
  r,
  spss,
  stata,
  jamovi;

  static StatisticalSoftware? fromString(String string) {
    switch (string) {
      case "-":
        return StatisticalSoftware.none;
      case "R":
        return StatisticalSoftware.r;
      case "SPSS":
        return StatisticalSoftware.spss;
      case "Stata":
        return StatisticalSoftware.stata;
      case "Jamovi":
        return StatisticalSoftware.jamovi;
      default:
        return null;
    }
  }

  static String asString(StatisticalSoftware statisticalSoftware) {
    for(String key in Constants.statisticalSoftwareMap.keys) {
      if(statisticalSoftware == Constants.statisticalSoftwareMap[key]) {
        return key;
      }
    }
    return "keine Angabe";
  }
}

enum Language {
  german,
  english;

  static Language? fromString(String string) {
    switch (string) {
      case "Deutsch":
        return Language.german;
      case "Englisch":
        return Language.english;
      default:
        return null;
    }
  }

  static String? asString(Language language) {
    for(String key in Constants.languageMap.keys) {
      if(language == Constants.languageMap[key]) {
        return key;
      }
    }
    return null;
  }
}

class OER {
  String name;
  String provider;
  String url;
  List<String> tags;
  List<Level> levels; //Filter: MultiSelect
  List<Medium> media; //Filter: MultiSelect
  bool licence; //Filter: Yes/No
  Subject subject; //Filter: MultiSelect
  StatisticalSoftware statisticalSoftware; //Filter: MultiSelect
  bool interactivity; //Filter: Yes/No
  bool exercises; //Filter: Yes/No
  bool visualisation; //Filter: Yes/No
  List<Language> languages; //Filter: MultiSelect
  String information;

  OER(
      this.name,
      this.provider,
      this.url,
      this.tags,
      this.levels,
      this.media,
      this.licence,
      this.subject,
      this.statisticalSoftware,
      this.interactivity,
      this.exercises,
      this.visualisation,
      this.languages,
      this.information);

  String toString() {
    return "OER: $name";
  }

  String printLicence(bool licence) {
    if(licence) {
      return "lizensiert";
    } else {
      return "keine OER-Lizenz";
    }
  }


  String printInteractivity(bool interactivity) {
    if(interactivity) {
      return "interaktives Lernmaterial";
    } else {
      return "keine interaktiven Materialien";
    }
  }

  String printExercises(bool exercises) {
    if(exercises) {
      return "mit Übungsaufgaben";
    } else {
      return "keine Übungsaufgaben";
    }
  }

  String printVisualisation(bool visualisation) {
    if(visualisation) {
      return "mit Visualisierungen";
    } else {
      return "keine Visualisierungen";
    }
  }

}


