import 'package:crypto_tracker_app/features/crypto_price/presentation/widgets/count_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/widgets/error_display.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/widgets/ticker_field.dart';
import 'package:crypto_tracker_app/features/crypto_price/presentation/widgets/result_price_list.dart';
import 'package:crypto_tracker_app/gen_l10n/app_localizations.dart';

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
  final _countController = TextEditingController();
  final _ticker1Controller = TextEditingController();
  final _ticker2Controller = TextEditingController();
  final _countFocus = FocusNode();
  final _ticker1Focus = FocusNode();
  final _ticker2Focus = FocusNode();
  final _buttonFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          loc.appTitle,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: CountField(
                controller: _countController,
                label: loc.count,
                helperText: '0.0000',
                currentNode: _countFocus,
                nextNode: _ticker1Focus,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TickerField(
                    controller: _ticker1Controller,
                    label: loc.coin1,
                    helperText: 'BTC',
                    currentNode: _ticker1Focus,
                    nextNode: _ticker2Focus,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                    child: const Icon(Icons.swap_horiz_rounded),
                  ),
                ),
                Expanded(
                  child: TickerField(
                    controller: _ticker2Controller,
                    label: loc.coin2,
                    helperText: 'USDT',
                    currentNode: _ticker2Focus,
                    nextNode: _buttonFocus,
                    onEditingComplete: () {
                      context.read<TitleCubit>().getPrice(
                        _ticker1Controller.text.trim(),
                        _ticker2Controller.text.trim(),
                        _countController.text,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              focusNode: _buttonFocus,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                context.read<TitleCubit>().getPrice(
                  _ticker1Controller.text.trim(),
                  _ticker2Controller.text.trim(),
                  _countController.text,
                );
              },
              child: Text(
                loc.getPrice,
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TitleCubit, TitleState>(
              builder: (context, state) {
                if (state is TitleInitial) {
                  return Text(
                    loc.enterTicker,
                    style: GoogleFonts.montserrat(fontSize: 16),
                  );
                } else if (state is TitleLoading) {
                  return Center(
                    child: Image.asset(
                      'assets/gifs/dance_cat.gif',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  );
                } else if (state is TitleLoaded) {
                  return ResultPriceList(
                    results: state.results,
                    localizeError: (code) => _localizeError(code, loc),
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

  String _localizeError(String? code, AppLocalizations loc) {
    switch (code) {
      case 'error_no_internet':
        return loc.error_no_internet;
      case 'error_fetch_failed':
        return loc.error_fetch_failed;
      case 'error_unknown':
        return loc.error_unknown;
      default:
        return loc.error_unknown;
    }
  }
}
