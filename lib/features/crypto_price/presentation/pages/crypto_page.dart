import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/crypto_cubit.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final _ticker1Controller = TextEditingController();
  final _ticker2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Price Checker')),
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
                      decoration: const InputDecoration(labelText: 'Coin 1'),
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
                  child: Icon(Icons.connecting_airports_sharp),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      maxLength: 5,
                      controller: _ticker2Controller,
                      decoration: const InputDecoration(labelText: 'Coin 2'),
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
              child: const Text('Get Price'),
            ),
            const SizedBox(height: 20),
            BlocBuilder<TitleCubit, TitleState>(
              builder: (context, state) {
                if (state is TitleInitial) {
                  return const Text('Please enter a ticker.');
                } else if (state is TitleLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TitleLoaded) {
                  return Text(
                    state.result,
                    style: const TextStyle(fontSize: 18),
                  );
                } else if (state is TitleError) {
                  return Text(
                    state.message,
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
