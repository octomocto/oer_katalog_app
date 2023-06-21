import '../model/oer.dart';

class Constants {
  static const String yesSign = "x";
  static const String noSign = "-";

  static final Map<String, Level> levelMap = {
    "Anfängerin": Level.beginner,
    "Grundwissen": Level.medium,
    "Fortgeschritten": Level.advanced
  };

  static final Map<String, Medium> mediaMap = {
    "Text": Medium.text,
    "Lexikon": Medium.encyclopaedia,
    "Manual": Medium.manual,
    "Blog": Medium.blog,
    "online-Buch": Medium.onlineBook,
    "online-Kurs": Medium.onlineCourse,
    "Audio": Medium.audio,
    "Video": Medium.video,
    "Vorlesungsaufzeichnung": Medium.lectureVideo,
    "Lehrmaterialien Hochschule": Medium.teachingMaterial
  };

  static final Map<String, Subject> subjectMap = {
    "Psychologie": Subject.psychology,
    "Bildungs- und Erziehungswissenschaften": Subject.education,
    "Soziologie": Subject.sociology,
    "Politikwissenschaften": Subject.politics,
    "Wirtschaft": Subject.economics
  };

  static final Map<String, StatisticalSoftware> statisticalSoftwareMap = {
    "keine Programmierbeispiele": StatisticalSoftware.none,
    "R": StatisticalSoftware.r,
    "SPSS": StatisticalSoftware.spss,
    "Stata": StatisticalSoftware.stata,
    "Jamovi": StatisticalSoftware.jamovi
  };

  static final Map<String, Language> languageMap = {
    "Deutsch": Language.german,
    "Englisch": Language.english
  };
}
