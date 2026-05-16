# QR One

QR One is a Flutter app for generating QR codes from text, links, phone numbers, and selected images. It includes Arabic and English language support, light/dark/system theme modes, local settings persistence, and quick copy/share actions.

## Features

- Generate QR codes from plain text.
- Generate QR codes from valid web links.
- Generate phone QR codes with numeric-only input.
- Pick an image and embed it inside the generated QR code.
- Copy QR payload content to the clipboard.
- Share the generated QR code as an image.
- Switch between Arabic and English.
- Switch between light, dark, and system themes.
- Save the last selected language and theme locally.

## Tech Stack

- Flutter
- Dart
- Riverpod
- qr_flutter
- image_picker
- share_plus
- path_provider

## Project Structure

```text
lib/
  main.dart
  models/
    app_language.dart
    input_kind.dart
    qr_one_state.dart
  screens/
    qr_one_page.dart
  services/
    qr_one_controller.dart
    settings_storage.dart
  utils/
    app_strings.dart
    app_theme.dart
  widgets/
    action_dock.dart
    input_panel.dart
    qr_panel.dart
    settings_menu.dart
    top_bar.dart
```

## Getting Started

Make sure Flutter is installed and configured on your machine.

```bash
flutter pub get
flutter run
```

## Checks

Run analyzer and tests:

```bash
flutter analyze
flutter test
```

## Repository

```text
https://github.com/Mohmmed-AlShweikh/QR
```
