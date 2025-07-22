import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_tracker_app/features/theme/cubit/theme_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeCubit', () {
    test('initial state is ThemeMode.system', () {
      final cubit = ThemeCubit();
      expect(cubit.state, ThemeMode.system);
    });

    test('loads saved theme from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      final cubit = ThemeCubit();
      await cubit.loadTheme();
      expect(cubit.state, ThemeMode.dark);
    });

    test('toggles theme and saves to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
      final cubit = ThemeCubit();
      await cubit.loadTheme();
      expect(cubit.state, ThemeMode.light);

      await cubit.toggleTheme();
      expect(cubit.state, ThemeMode.dark);
    });
  });
}
