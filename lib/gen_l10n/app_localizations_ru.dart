// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Курс Криптовалют';

  @override
  String get switchLanguage => 'Переключить на английский';

  @override
  String get switchTheme => 'Переключить на стиль';

  @override
  String get getPrice => 'Узнать курс';

  @override
  String get coin1 => 'Монета 1';

  @override
  String get coin2 => 'Монета 2';

  @override
  String get enterTicker => 'Введите тикер.';

  @override
  String get error_fetch_failed => 'Не удалось получить цену';

  @override
  String get error_no_internet => 'Нет подключения к интернету';

  @override
  String get error_unknown => 'Произошла неизвестная ошибка';
}
