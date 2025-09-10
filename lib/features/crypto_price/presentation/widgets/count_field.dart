import 'package:crypto_tracker_app/core/utils/number_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class CountField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String helperText;
  final FocusNode currentNode;
  final FocusNode? nextNode;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final void Function(String)? onFieldSubmitted;

  const CountField({
    super.key,
    required this.controller,
    required this.label,
    required this.helperText,
    required this.currentNode,
    this.nextNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      textInputAction:
          nextNode != null ? TextInputAction.next : TextInputAction.done,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        DoubleInputFormatter(),
      ],
      onFieldSubmitted: (value) {
        final normalized = value.replaceAll(',', '.');
        print('!!!!!!!!!!onFieldSubmitted $normalized');
        onFieldSubmitted?.call(normalized);
      },
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      focusNode: currentNode,

      controller: controller,
      textCapitalization: TextCapitalization.characters,
      style: GoogleFonts.montserrat(fontSize: 16),
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        helperText: helperText,
        labelStyle: GoogleFonts.montserrat(color: Colors.grey[700]),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ),
      ),
    );
  }
}
