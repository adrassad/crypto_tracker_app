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

  const CountField({
    super.key,
    required this.controller,
    required this.label,
    required this.helperText,
    required this.currentNode,
    this.nextNode,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        DoubleInputFormatter(),
      ],
      onFieldSubmitted: (_) {
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      onEditingComplete: () {
        if (controller.text.isEmpty) {
          controller.text = '1';
        }
      },
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
