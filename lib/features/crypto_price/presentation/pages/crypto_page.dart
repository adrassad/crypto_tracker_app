import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/crypto_cubit.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final _tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Price Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _tickerController,
              decoration: const InputDecoration(labelText: 'Enter ticker'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<TitleCubit>().getPrice(
                  _tickerController.text.trim(),
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
