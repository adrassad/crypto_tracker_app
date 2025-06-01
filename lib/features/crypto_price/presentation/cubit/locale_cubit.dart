import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('locale') ?? 'en';
    emit(Locale(langCode));
  }

  Future<void> toggleLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final newLocale = state.languageCode == 'en' ? 'ru' : 'en';
    await prefs.setString('locale', newLocale);
    emit(Locale(newLocale));
  }
}
