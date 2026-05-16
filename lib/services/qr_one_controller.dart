import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/app_language.dart';
import '../models/input_kind.dart';
import '../models/qr_one_state.dart';
import 'settings_storage.dart';

class QrOneController extends Notifier<QrOneState> {
  final _settingsStorage = const SettingsStorage();

  @override
  QrOneState build() {
    _loadSavedSettings();
    return QrOneState.initial();
  }

  void setLanguage(AppLanguage language) {
    state = state.copyWith(language: language);
    _saveSettings();
  }

  void setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    _saveSettings();
  }

  void setInputKind(InputKind inputKind) {
    final nextValue = switch (inputKind) {
      InputKind.phone => state.value.replaceAll(RegExp(r'[^0-9]'), ''),
      InputKind.link => state.value.replaceAll(RegExp(r'\s+'), ''),
      InputKind.image => '',
      InputKind.text => state.value,
    };

    state = state.copyWith(
      inputKind: inputKind,
      value: nextValue,
      clearImage: inputKind != InputKind.image,
    );
  }

  void setValue(String value) {
    final sanitized = switch (state.inputKind) {
      InputKind.phone => value.replaceAll(RegExp(r'[^0-9]'), ''),
      InputKind.link => value.replaceAll(RegExp(r'\s+'), ''),
      InputKind.image => '',
      InputKind.text => value,
    };

    state = state.copyWith(value: sanitized);
  }

  void setImage(XFile image) {
    state = state.copyWith(
      inputKind: InputKind.image,
      imagePath: image.path,
      imageName: image.name,
      value: '',
    );
  }

  void clearImage() {
    state = state.copyWith(clearImage: true);
  }

  Future<void> _loadSavedSettings() async {
    final settings = await _settingsStorage.read();
    if (settings == null) return;

    state = state.copyWith(
      language: settings.language,
      themeMode: settings.themeMode,
    );
  }

  Future<void> _saveSettings() async {
    await _settingsStorage.write(
      language: state.language,
      themeMode: state.themeMode,
    );
  }
}

final qrOneProvider = NotifierProvider<QrOneController, QrOneState>(
  QrOneController.new,
);
