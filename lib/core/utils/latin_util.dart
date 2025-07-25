class LatinUtil {
  static String onlyLatin(String input) {
    final latinRegExp = RegExp(r'[a-zA-Z]');
    return input.split('').where((c) => latinRegExp.hasMatch(c)).join();
  }
}
