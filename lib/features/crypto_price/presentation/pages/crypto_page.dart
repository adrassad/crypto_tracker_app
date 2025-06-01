import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/crypto_cubit.dart';
import 'package:flutter/cupertino.dart';

class CryptoPage extends StatefulWidget {
  final VoidCallback onToggleLocale;
  const CryptoPage({super.key, required this.onToggleLocale});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final _ticker1Controller = TextEditingController();
  final _ticker2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.onToggleLocale,
            tooltip: loc.switchLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      maxLength: 5,
                      controller: _ticker1Controller,
                      decoration: InputDecoration(labelText: loc.coin1),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var text1 = _ticker1Controller.text;
                    var text2 = _ticker2Controller.text;
                    _ticker1Controller.text = text2;
                    _ticker2Controller.text = text1;
                  },
                  child: const Icon(CupertinoIcons.arrow_left_right),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      maxLength: 5,
                      controller: _ticker2Controller,
                      decoration: InputDecoration(labelText: loc.coin2),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<TitleCubit>().getPrice(
                  _ticker1Controller.text.trim(),
                  _ticker2Controller.text.trim(),
                );
              },
              child: Text(loc.getPrice),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TitleCubit, TitleState>(
              builder: (context, state) {
                if (state is TitleInitial) {
                  return Text(loc.enterTicker);
                } else if (state is TitleLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TitleLoaded) {
                  return Text(
                    state.result,
                    style: const TextStyle(fontSize: 18),
                  );
                } else if (state is TitleError) {
                  return Text(
                    state.errorCode,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
