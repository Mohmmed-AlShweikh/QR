import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/qr_one_controller.dart';
import '../utils/app_strings.dart';
import 'settings_menu.dart';

class TopBar extends ConsumerWidget {
  const TopBar({required this.text, super.key});

  final AppStrings text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qrOneProvider);
    final controller = ref.read(qrOneProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'QR One',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text.tagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.68),
                ),
              ),
            ],
          ),
        ),
        SettingsMenu(
          text: text,
          language: state.language,
          themeMode: state.themeMode,
          onLanguageChanged: controller.setLanguage,
          onThemeChanged: controller.setThemeMode,
        ),
      ],
    );
  }
}
