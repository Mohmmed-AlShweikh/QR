import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/qr_one_page.dart';
import 'services/qr_one_controller.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: QrOneApp()));
}

class QrOneApp extends ConsumerWidget {
  const QrOneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qrOneProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR One',
      themeMode: state.themeMode,
      theme: AppTheme.build(Brightness.light),
      darkTheme: AppTheme.build(Brightness.dark),
      home: Directionality(
        textDirection: state.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: const QrOnePage(),
      ),
    );
  }
}
