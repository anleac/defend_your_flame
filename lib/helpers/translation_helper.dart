import 'package:defend_your_flame/constants/translations/app_strings.dart';

class TranslationHelper {
  static String insertNumber(String s, int n) => insertString(s, n.toString());

  static String insertString(String s, String n) {
    if (!s.contains(AppStrings.placeholderText)) {
      throw Exception("$s does not contain the expected placeholder");
    }

    return s.replaceFirst(AppStrings.placeholderText, n);
  }

  static String insertStrings(String s, List<String> ns) {
    if (!s.contains(AppStrings.placeholderText)) {
      throw Exception("$s does not contain the expected placeholder");
    }
    int ni = 0;
    return s.replaceAllMapped(AppStrings.placeholderText, (m) => ns[ni++]);
  }

  static String insertNumbers(String s, List<int> ns) {
    if (!s.contains(AppStrings.placeholderText)) {
      throw Exception("$s does not contain the expected placeholder");
    }

    int ni = 0;
    return s.replaceAllMapped(AppStrings.placeholderText, (m) => ns[ni++].toString());
  }
}
