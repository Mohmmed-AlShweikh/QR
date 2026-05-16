import 'package:flutter/material.dart';

import 'app_language.dart';
import 'input_kind.dart';

class QrOneState {
  const QrOneState({
    required this.language,
    required this.themeMode,
    required this.inputKind,
    required this.value,
    this.imagePath,
    this.imageName,
  });

  factory QrOneState.initial() => const QrOneState(
    language: AppLanguage.ar,
    themeMode: ThemeMode.system,
    inputKind: InputKind.text,
    value: '',
  );

  final AppLanguage language;
  final ThemeMode themeMode;
  final InputKind inputKind;
  final String value;
  final String? imagePath;
  final String? imageName;

  bool get isArabic => language == AppLanguage.ar;

  String get qrData {
    final trimmed = value.trim();
    switch (inputKind) {
      case InputKind.link:
        if (trimmed.isEmpty) return '';
        final normalized = _normalizedWebLink(trimmed);
        return normalized ?? '';
      case InputKind.phone:
        return trimmed.isEmpty ? '' : 'tel:$trimmed';
      case InputKind.image:
        if (imageName == null) return '';
        return 'image:$imageName';
      case InputKind.text:
        return trimmed;
    }
  }

  String? _normalizedWebLink(String value) {
    final normalized =
        value.startsWith('http://') || value.startsWith('https://')
        ? value
        : 'https://$value';
    final uri = Uri.tryParse(normalized);
    if (uri == null || !uri.hasAuthority) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    if (!uri.host.contains('.')) return null;
    return normalized;
  }

  QrOneState copyWith({
    AppLanguage? language,
    ThemeMode? themeMode,
    InputKind? inputKind,
    String? value,
    String? imagePath,
    String? imageName,
    bool clearImage = false,
  }) {
    return QrOneState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      inputKind: inputKind ?? this.inputKind,
      value: value ?? this.value,
      imagePath: clearImage ? null : imagePath ?? this.imagePath,
      imageName: clearImage ? null : imageName ?? this.imageName,
    );
  }
}
