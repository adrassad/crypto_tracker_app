import 'package:crypto_tracker_app/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String errorCode;
  const ErrorDisplay({required this.errorCode, super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    String errorMessage;

    switch (errorCode) {
      case 'error_no_internet':
        errorMessage = loc.error_no_internet;
        break;
      case 'error_fetch_failed':
        errorMessage = loc.error_fetch_failed;
        break;
      default:
        errorMessage = loc.error_unknown;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
