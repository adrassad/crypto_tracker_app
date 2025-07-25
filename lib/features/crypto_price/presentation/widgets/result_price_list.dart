import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPriceList extends StatelessWidget {
  final List results;
  final String Function(String? code) localizeError;

  const ResultPriceList({
    super.key,
    required this.results,
    required this.localizeError,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          localizeError(null),
          style: GoogleFonts.montserrat(fontSize: 18, color: Colors.red),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: results.length,
        itemBuilder: (context, idx) {
          final e = results[idx];
          final providerName = e.provider.providerName.toUpperCase();

          String priceStr = '';
          if (e.price != null && e.price != 0) {
            priceStr = e.price!.toStringAsFixed(8);
          }

          String integerPart = '';
          String fractionalPart = '';
          if (priceStr.isNotEmpty) {
            final parts = priceStr.split('.');
            integerPart = parts[0];
            fractionalPart = parts.length > 1 ? parts[1] : '';
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child:
                  priceStr.isNotEmpty
                      ? Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  providerName,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      integerPart,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      fractionalPart.isNotEmpty
                                          ? '.${fractionalPart.toLowerCase()}'
                                          : '',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      : Text(
                        '$providerName: ❌ ${localizeError(e.error)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
