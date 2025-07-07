import 'package:crypto_tracker_app/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'features/crypto_price/presentation/cubit/locale_cubit.dart';
import 'features/crypto_price/presentation/pages/crypto_page.dart';
import 'core/di/di.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final localeCubit = LocaleCubit();
  await localeCubit.loadLocale();
  runApp(
    BlocProvider<LocaleCubit>.value(value: localeCubit, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          title: 'Crypto Price',
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ru')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: BlocProvider(
            create: (_) => di<TitleCubit>(),
            child: CryptoPage(
              onToggleLocale: () {
                context.read<LocaleCubit>().toggleLocale();
              },
            ),
          ),
        );
      },
    );
  }
}
