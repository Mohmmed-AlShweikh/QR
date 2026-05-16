import 'package:flutter/material.dart';

import '../models/app_language.dart';
import '../utils/app_strings.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({
    required this.text,
    required this.language,
    required this.themeMode,
    required this.onLanguageChanged,
    required this.onThemeChanged,
    super.key,
  });

  final AppStrings text;
  final AppLanguage language;
  final ThemeMode themeMode;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: text.settings,
      icon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: Colors.black.withValues(alpha: 0.08),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.tune_rounded),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Text(
            text.language,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        CheckedPopupMenuItem<String>(
          value: 'ar',
          checked: language == AppLanguage.ar,
          child: const Text('العربية'),
        ),
        CheckedPopupMenuItem<String>(
          value: 'en',
          checked: language == AppLanguage.en,
          child: const Text('English'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          enabled: false,
          child: Text(
            text.theme,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        CheckedPopupMenuItem<String>(
          value: 'system',
          checked: themeMode == ThemeMode.system,
          child: Text(text.system),
        ),
        CheckedPopupMenuItem<String>(
          value: 'light',
          checked: themeMode == ThemeMode.light,
          child: Text(text.light),
        ),
        CheckedPopupMenuItem<String>(
          value: 'dark',
          checked: themeMode == ThemeMode.dark,
          child: Text(text.dark),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'ar':
            onLanguageChanged(AppLanguage.ar);
            break;
          case 'en':
            onLanguageChanged(AppLanguage.en);
            break;
          case 'system':
            onThemeChanged(ThemeMode.system);
            break;
          case 'light':
            onThemeChanged(ThemeMode.light);
            break;
          case 'dark':
            onThemeChanged(ThemeMode.dark);
            break;
        }
      },
    );
  }
}
