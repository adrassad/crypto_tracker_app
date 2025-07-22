import 'package:crypto_tracker_app/core/di/di.dart';
import 'package:crypto_tracker_app/features/theme/cubit/theme_cubit.dart';
import 'package:crypto_tracker_app/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/crypto_price/presentation/cubit/crypto_cubit.dart';
import 'features/crypto_price/presentation/cubit/locale_cubit.dart';
import 'features/crypto_price/presentation/pages/crypto_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final localeCubit = LocaleCubit();
  await localeCubit.loadLocale();
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>.value(value: localeCubit),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeMode,
              title: 'Crypto Price',
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ru')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: BlocProvider(
                create: (_) => di<TitleCubit>(),
                child: CryptoPage(
                  onToggleLocale: () {
                    context.read<LocaleCubit>().toggleLocale();
                  },
                  onToggleTheme: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
