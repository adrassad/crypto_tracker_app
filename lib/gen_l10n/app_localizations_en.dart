// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crypto Price';

  @override
  String get switchLanguage => 'Switch to Russian';

  @override
  String get switchTheme => 'Switch Theme';

  @override
  String get getPrice => 'Get Price';

  @override
  String get coin1 => 'Coin 1';

  @override
  String get coin2 => 'Coin 2';

  @override
  String get enterTicker => 'Please enter a ticker.';

  @override
  String get error_fetch_failed => 'Failed to fetch price';

  @override
  String get error_no_internet => 'No internet connection';

  @override
  String get error_unknown => 'Unknown error occurred';
}
