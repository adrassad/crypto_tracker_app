# 💸 Crypto Tracker App

[![Flutter](https://img.shields.io/badge/flutter-3.22%2B-blue?logo=flutter)](https://flutter.dev)
[![Stars](https://img.shields.io/github/stars/adrassad/crypto_tracker_app?style=social)](https://github.com/adrassad/crypto_tracker_app/stargazers)
[![License](https://img.shields.io/github/license/adrassad/crypto_tracker_app)](LICENSE)
[![Build](https://github.com/adrassad/crypto_tracker_app/actions/workflows/flutter.yml/badge.svg)](https://github.com/adrassad/crypto_tracker_app/actions)

**Crypto Tracker App** is a cross-platform Flutter application that allows users to track real-time cryptocurrency exchange rates. It features language switching, light/dark theme support, and modern architecture based on `Bloc` and `Cubit`.

## 📱 Features

- 🔎 Enter two crypto tickers and get the current exchange rate between them.
- 🌐 Multi-language support (🇬🇧 English, 🇷🇺 Russian) with instant switching.
- 🌓 Toggle between light and dark themes.
- ⚙️ Reactive architecture using `Bloc`/`Cubit`.
- 🧪 Clean error handling with user-friendly messages.
- 🎨 Elegant UI using Material 3 and Google Fonts.

## 🧱 Architecture

The app follows a **Feature-First Clean Architecture** pattern:

lib/
├── core/
│   ├── di/                 # Dependency injection setup
│   ├── theme/              # ThemeCubit
├── features/
│   └── crypto_price/
│       ├── data/           # Data sources (future)
│       ├── domain/         # Business logic (future)
│       └── presentation/
│           ├── cubit/      # TitleCubit, LocaleCubit, ThemeCubit
│           ├── widgets/    # UI components
│           └── pages/      # CryptoPage screen
├── gen_l10n/               # Generated localization files

## 🛠️ Tech Stack

- Flutter 3.22+
- Dart
- flutter_bloc
- Google Fonts
- Material 3
- flutter_localizations
- Clean Architecture (feature-based)

## 🚀 Getting Started

```bash
git clone https://github.com/adrassad/crypto_tracker_app.git
cd crypto_tracker_app
flutter pub get
flutter run

🌍 Screenshots
Light Theme
Dark Theme



📌 Roadmap
	•	Display historical price charts
	•	Favorite coins list
	•	Real API integration (CoinGecko, CoinMarketCap)
	•	Authentication and portfolio tracking
	•	Firebase or Supabase integration

👨‍💻 Author

adrassad — GitHub Profile

⸻

If you like the project, consider giving it a ⭐️ on GitHub!