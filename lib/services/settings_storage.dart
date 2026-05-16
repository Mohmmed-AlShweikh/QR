import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/app_language.dart';

class SavedSettings {
  const SavedSettings({required this.language, required this.themeMode});

  final AppLanguage language;
  final ThemeMode themeMode;
}

class SettingsStorage {
  const SettingsStorage();

  static const _fileName = 'qr_one_settings.json';
  static const _languageKey = 'language';
  static const _themeKey = 'themeMode';

  Future<SavedSettings?> read() async {
    final file = await _settingsFile();
    if (!await file.exists()) return null;

    try {
      final data =
          jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return SavedSettings(
        language: _languageFromName(data[_languageKey] as String?),
        themeMode: _themeFromName(data[_themeKey] as String?),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> write({
    required AppLanguage language,
    required ThemeMode themeMode,
  }) async {
    final file = await _settingsFile();
    await file.writeAsString(
      jsonEncode({_languageKey: language.name, _themeKey: themeMode.name}),
      flush: true,
    );
  }

  Future<File> _settingsFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/$_fileName');
  }

  AppLanguage _languageFromName(String? name) {
    return AppLanguage.values.firstWhere(
      (language) => language.name == name,
      orElse: () => AppLanguage.ar,
    );
  }

  ThemeMode _themeFromName(String? name) {
    return ThemeMode.values.firstWhere(
      (themeMode) => themeMode.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}
