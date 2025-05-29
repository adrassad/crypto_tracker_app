import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'features/crypto_price/presentation/pages/crypto_page.dart';
import 'core/di/di.dart';

void main() {
  setupDependencies();
  print('Dependencies initialized.');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Price',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => di<TitleCubit>(),
        child: const CryptoPage(),
      ),
    );
  }
}
