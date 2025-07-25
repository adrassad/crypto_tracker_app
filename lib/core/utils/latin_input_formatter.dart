import 'package:flutter/services.dart';

class LatinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final latinOnly = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9.]'), '');
    return newValue.copyWith(
      text: latinOnly,
      selection: TextSelection.collapsed(offset: latinOnly.length),
    );
  }
}
