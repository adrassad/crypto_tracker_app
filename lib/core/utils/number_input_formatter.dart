import 'package:flutter/services.dart';

class DoubleInputFormatter extends TextInputFormatter {
  final bool allowNegative;
  final int? decimalRange;

  DoubleInputFormatter({this.allowNegative = false, this.decimalRange});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;

    // Разрешаем только цифры, одну точку и (опционально) минус в начале
    String pattern = allowNegative ? r'^?\d*\.?\d*$' : r'^\d*\.?\d*$';
    if (!RegExp(pattern).hasMatch(value)) {
      return oldValue;
    }

    if (decimalRange != null && value.contains('.')) {
      final decimals = value.split('.');
      if (decimals.length > 1 && decimals[1].length > decimalRange!) {
        return oldValue;
      }
    }

    return newValue;
  }
}
