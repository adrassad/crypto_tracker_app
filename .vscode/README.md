# VS Code Configuration for Crypto Tracker App

This directory contains VS Code configuration files that enhance the development experience for this Flutter project.

## 📁 Files Overview

### `settings.json`
Project-specific settings including:
- **File Explorer**: Hides build artifacts and generated files for a cleaner view
- **File Nesting**: Groups related files together (e.g., `.dart` with `.g.dart` and `.freezed.dart`)
- **Dart/Flutter**: Enables format-on-save, UI guides, and other helpful features
- **Search**: Excludes generated and build files from search results

### `extensions.json`
Recommended VS Code extensions for Flutter development:
- **Dart & Flutter**: Essential language support
- **Bloc**: Snippets for BLoC pattern development
- **Error Lens**: Inline error highlighting
- **Todo Highlight**: Highlight TODO and FIXME comments
- **GitLens**: Advanced Git features
- **Code Spell Checker**: Catch typos in your code

### `launch.json`
Debug configurations for:
- **Development Mode**: Default debug configuration
- **Profile Mode**: For performance testing
- **Release Mode**: Test release builds
- **Chrome**: Web-specific debugging
- **All Tests**: Run all unit tests

### `tasks.json`
Quick tasks accessible via `Ctrl+Shift+B` (Windows/Linux) or `Cmd+Shift+B` (macOS):
- **Flutter: Get Packages** - Run `flutter pub get`
- **Flutter: Clean** - Clean build artifacts
- **Flutter: Build Runner** - Generate code with build_runner
- **Flutter: Watch Build Runner** - Continuously watch for changes
- **Flutter: Analyze** - Run static analysis
- **Flutter: Test** - Run all tests
- **Flutter: Generate Icons** - Generate app icons
- **Flutter: Generate Localization** - Generate i18n files

## 🚀 Usage

### Opening the Project
For the best experience, open the workspace file:
```bash
code crypto_tracker_app.code-workspace
```

Or simply open the folder:
```bash
code .
```

### Running Tasks
1. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. Type "Tasks: Run Task"
3. Select the task you want to run

### Debugging
1. Open the Run and Debug view (`Ctrl+Shift+D` or `Cmd+Shift+D`)
2. Select a configuration from the dropdown
3. Press F5 to start debugging

## 📂 Project Structure

The file explorer will display a clean, organized view:

```
crypto_tracker_app/
├── lib/                    # Source code
│   ├── core/              # Core utilities
│   │   ├── di/           # Dependency injection
│   │   ├── error/        # Error handling
│   │   └── utils/        # Utilities
│   ├── features/          # Feature modules
│   │   ├── crypto_price/ # Crypto price tracking
│   │   │   ├── data/    # Data layer
│   │   │   ├── domain/  # Business logic
│   │   │   └── presentation/ # UI layer
│   │   └── theme/        # Theme management
│   ├── gen_l10n/         # Generated localization
│   ├── l10n/             # Localization files
│   └── main.dart         # App entry point
├── test/                  # Unit & widget tests
├── android/              # Android platform
├── ios/                  # iOS platform
├── web/                  # Web platform
├── windows/              # Windows platform
├── linux/                # Linux platform
├── macos/                # macOS platform
└── assets/               # Static assets

```

## 🔧 Customization

Feel free to modify these configurations based on your preferences:
- Adjust `editor.rulers` in `settings.json` for different line length limits
- Add/remove recommended extensions in `extensions.json`
- Create custom tasks in `tasks.json` for your workflow

## 💡 Tips

1. **File Nesting**: Press the expand icon next to files to see grouped generated files
2. **Format on Save**: Code automatically formats when you save (configurable in settings)
3. **Import Organization**: Imports are automatically organized on save
4. **Quick Fix**: Use `Ctrl+.` or `Cmd+.` for quick fixes and refactoring options

## 📚 Learn More

- [VS Code for Flutter](https://flutter.dev/docs/development/tools/vs-code)
- [Dart VS Code Extension](https://dartcode.org/)
- [VS Code Tips & Tricks](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
