# 📂 Структура проекта в VS Code

Этот документ описывает настройку проекта для оптимальной работы в VS Code.

## ✅ Что было настроено

### 1. 📁 Директория `.vscode/`

Содержит все конфигурационные файлы для VS Code:

#### `settings.json`
- **Скрытие файлов**: Автоматически скрывает сгенерированные файлы и артефакты сборки
- **Вложенность файлов**: Группирует связанные файлы (например, `.dart` с `.g.dart`)
- **Форматирование**: Автоматическое форматирование кода при сохранении
- **Dart/Flutter**: Включает подсказки UI и другие полезные функции

#### `extensions.json`
Рекомендуемые расширения для разработки:
- `Dart Code` - Поддержка языка Dart
- `Flutter` - Поддержка Flutter framework
- `Bloc` - Сниппеты для паттерна BLoC
- `Error Lens` - Встроенное отображение ошибок
- `Todo Highlight` - Подсветка TODO комментариев
- `GitLens` - Расширенные возможности Git

#### `launch.json`
Конфигурации для отладки:
- **Development Mode** - Режим разработки (по умолчанию)
- **Profile Mode** - Для тестирования производительности
- **Release Mode** - Тестирование релизной сборки
- **Chrome** - Отладка веб-версии
- **All Tests** - Запуск всех тестов

#### `tasks.json`
Быстрые команды для разработки:
- `Flutter: Get Packages` - Установка зависимостей
- `Flutter: Clean` - Очистка артефактов сборки
- `Flutter: Build Runner` - Генерация кода
- `Flutter: Watch Build Runner` - Непрерывная генерация кода
- `Flutter: Analyze` - Статический анализ кода
- `Flutter: Test` - Запуск тестов
- `Flutter: Generate Icons` - Генерация иконок приложения
- `Flutter: Generate Localization` - Генерация файлов локализации

### 2. 📋 Файл `crypto_tracker_app.code-workspace`

Workspace файл для организованного отображения проекта:
- 🏠 Root - Корневая директория
- 📚 Source Code (lib) - Исходный код
- 🧪 Tests - Тесты
- 📱 Android - Android платформа
- 🍎 iOS - iOS платформа
- 🌐 Web - Web платформа
- 🪟 Windows - Windows платформа
- 🐧 Linux - Linux платформа
- 💻 macOS - macOS платформа
- 🎨 Assets - Статические ресурсы

## 🚀 Как использовать

### Открытие проекта

**Вариант 1**: Открыть workspace файл (рекомендуется)
```bash
code crypto_tracker_app.code-workspace
```

**Вариант 2**: Открыть обычную папку
```bash
code .
```

### Запуск задач

1. Нажмите `Ctrl+Shift+P` (Windows/Linux) или `Cmd+Shift+P` (macOS)
2. Введите "Tasks: Run Task"
3. Выберите нужную задачу

Или быстрый доступ: `Ctrl+Shift+B` / `Cmd+Shift+B`

### Отладка

1. Откройте панель "Run and Debug" (`Ctrl+Shift+D` / `Cmd+Shift+D`)
2. Выберите конфигурацию из выпадающего списка
3. Нажмите F5 для начала отладки

## 📊 Структура проекта

```
crypto_tracker_app/
├── .vscode/                    # Конфигурация VS Code
│   ├── settings.json          # Настройки проекта
│   ├── extensions.json        # Рекомендуемые расширения
│   ├── launch.json            # Конфигурации отладки
│   ├── tasks.json             # Задачи для разработки
│   └── README.md              # Документация (English)
│
├── lib/                        # Исходный код
│   ├── core/                  # Базовые утилиты
│   │   ├── di/               # Dependency Injection
│   │   ├── error/            # Обработка ошибок
│   │   └── utils/            # Вспомогательные функции
│   │
│   ├── features/              # Модули приложения
│   │   ├── crypto_price/     # Отслеживание цен криптовалют
│   │   │   ├── data/        # Слой данных
│   │   │   ├── domain/      # Бизнес-логика
│   │   │   └── presentation/# UI слой
│   │   └── theme/            # Управление темой
│   │
│   ├── gen_l10n/             # Генерированные файлы локализации
│   ├── l10n/                 # Файлы переводов
│   └── main.dart             # Точка входа в приложение
│
├── test/                      # Модульные и виджет тесты
├── android/                   # Платформа Android
├── ios/                       # Платформа iOS
├── web/                       # Платформа Web
├── windows/                   # Платформа Windows
├── linux/                     # Платформа Linux
├── macos/                     # Платформа macOS
├── assets/                    # Статические ресурсы
│
└── crypto_tracker_app.code-workspace  # Workspace файл
```

## 🎯 Основные возможности

### 1. Чистый Explorer
Файлы сборки и генерированные файлы автоматически скрыты:
- `.dart_tool/`, `build/`
- `*.g.dart`, `*.freezed.dart`, `*.mocks.dart`
- `.flutter-plugins`, `pubspec.lock`

### 2. Вложенность файлов
Связанные файлы группируются вместе:
- `user.dart` → `user.g.dart`, `user.freezed.dart`
- `pubspec.yaml` → `pubspec.lock`, `.flutter-plugins`

### 3. Автоматическое форматирование
- Форматирование при сохранении
- Организация импортов
- Исправление ошибок линтера

### 4. Умный поиск
Поиск исключает ненужные файлы для быстрых результатов.

## 💡 Полезные советы

### Горячие клавиши

| Действие | Windows/Linux | macOS |
|----------|---------------|-------|
| Командная панель | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| Быстрый доступ к файлам | `Ctrl+P` | `Cmd+P` |
| Поиск по проекту | `Ctrl+Shift+F` | `Cmd+Shift+F` |
| Запуск задачи | `Ctrl+Shift+B` | `Cmd+Shift+B` |
| Отладка | `F5` | `F5` |
| Панель отладки | `Ctrl+Shift+D` | `Cmd+Shift+D` |
| Быстрое исправление | `Ctrl+.` | `Cmd+.` |
| Переименование символа | `F2` | `F2` |
| Перейти к определению | `F12` | `F12` |

### Работа с файлами

1. **Раскрытие вложенных файлов**: Нажмите на стрелку рядом с файлом
2. **Фильтрация в Explorer**: Используйте поиск в верхней части панели Explorer
3. **Быстрое переключение**: `Ctrl+Tab` для переключения между открытыми файлами

### Советы по Flutter

1. **Hot Reload**: `Ctrl+F5` (Windows/Linux) / `Cmd+F5` (macOS)
2. **Hot Restart**: Введите `r` в терминале где запущен Flutter
3. **Виджет инспектор**: Откройте DevTools через командную панель
4. **Переход к виджету**: `Ctrl+Click` на виджет в коде

## 🔧 Настройка

Все настройки можно изменить в соответствующих файлах:
- Измените правила линтера в `analysis_options.yaml`
- Настройте форматирование в `.vscode/settings.json`
- Добавьте свои задачи в `.vscode/tasks.json`
- Создайте новые конфигурации отладки в `.vscode/launch.json`

## 📚 Дополнительные ресурсы

- [Flutter в VS Code](https://flutter.dev/docs/development/tools/vs-code)
- [Расширение Dart для VS Code](https://dartcode.org/)
- [Советы и трюки VS Code](https://code.visualstudio.com/docs/getstarted/tips-and-tricks)
- [Документация Flutter](https://flutter.dev/docs)
- [Паттерн BLoC](https://bloclibrary.dev/)

## ✨ Итог

Теперь ваш проект полностью настроен для комфортной работы в VS Code! Все конфигурации оптимизированы для разработки на Flutter с использованием паттерна BLoC и Clean Architecture.

Приятной разработки! 🚀
