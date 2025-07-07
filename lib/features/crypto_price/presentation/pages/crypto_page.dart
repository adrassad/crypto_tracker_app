import 'package:crypto_tracker_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/widgets/error_display.dart';
import 'package:crypto_tracker_app/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoPage extends StatefulWidget {
  final VoidCallback onToggleLocale;
  final VoidCallback onToggleTheme;
  const CryptoPage({
    super.key,
    required this.onToggleLocale,
    required this.onToggleTheme,
  });

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final _ticker1Controller = TextEditingController();
  final _ticker2Controller = TextEditingController();
  final _ticker1Focus = FocusNode();
  final _ticker2Focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      //backgroundColor: const Color(0xFFF9F7F7),
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          loc.appTitle,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.language,
              //color: Colors.black87
            ),
            onPressed: widget.onToggleLocale,
            tooltip: loc.switchLanguage,
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: loc.switchTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTickerField(
                    _ticker1Controller,
                    loc.coin1,
                    _ticker1Focus,
                    _ticker2Focus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.deepPurple.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(48, 48),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      final temp = _ticker1Controller.text;
                      _ticker1Controller.text = _ticker2Controller.text;
                      _ticker2Controller.text = temp;
                    },
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      //color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: _buildTickerField(
                    _ticker2Controller,
                    loc.coin2,
                    _ticker2Focus,
                    _ticker1Focus,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.deepPurple.shade400,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                context.read<TitleCubit>().getPrice(
                  _ticker1Controller.text.trim(),
                  _ticker2Controller.text.trim(),
                );
              },
              child: Text(
                loc.getPrice,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  // color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<TitleCubit, TitleState>(
              builder: (context, state) {
                if (state is TitleInitial) {
                  return Text(
                    loc.enterTicker,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      //      color: Colors.black54,
                    ),
                  );
                } else if (state is TitleLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TitleLoaded) {
                  return Text(
                    state.result,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      //    color: Colors.black87,
                    ),
                  );
                } else if (state is TitleError) {
                  return ErrorDisplay(errorCode: state.errorCode);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTickerField(
    TextEditingController controller,
    String label,
    FocusNode currentNode,
    FocusNode? nextNode,
  ) {
    return TextFormField(
      onFieldSubmitted: (_) {
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onEditingComplete: () {
        if (nextNode != null && nextNode == _ticker1Focus) {
          context.read<TitleCubit>().getPrice(
            _ticker1Controller.text.trim(),
            _ticker2Controller.text.trim(),
          );
        } else {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onTapOutside: (_) => currentNode.unfocus(),
      focusNode: currentNode,
      controller: controller,
      maxLength: 5,
      textCapitalization: TextCapitalization.characters,
      style: GoogleFonts.montserrat(fontSize: 16),
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        labelStyle: GoogleFonts.montserrat(color: Colors.grey[700]),
        filled: true,
        //fillColor: Colors.white,
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
