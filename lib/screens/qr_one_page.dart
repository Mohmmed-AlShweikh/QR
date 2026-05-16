import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/qr_one_controller.dart';
import '../utils/app_strings.dart';
import '../widgets/action_dock.dart';
import '../widgets/input_panel.dart';
import '../widgets/qr_panel.dart';
import '../widgets/top_bar.dart';

class QrOnePage extends ConsumerStatefulWidget {
  const QrOnePage({super.key});

  @override
  ConsumerState<QrOnePage> createState() => _QrOnePageState();
}

class _QrOnePageState extends ConsumerState<QrOnePage> {
  final _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(qrOneProvider);
    final text = AppStrings.of(state.language);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.primaryContainer.withValues(alpha: 0.34),
              Theme.of(context).scaffoldBackgroundColor,
              colors.secondaryContainer.withValues(alpha: 0.24),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 760;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isWide ? 34 : 18,
                  16,
                  isWide ? 34 : 18,
                  22,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TopBar(text: text),
                        const SizedBox(height: 22),
                        isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: InputPanel(text: text)),
                                  const SizedBox(width: 22),
                                  Expanded(child: QrPanel(qrKey: _qrKey)),
                                ],
                              )
                            : Column(
                                children: [
                                  QrPanel(qrKey: _qrKey),
                                  const SizedBox(height: 18),
                                  InputPanel(text: text),
                                ],
                              ),
                        const SizedBox(height: 18),
                        ActionDock(
                          text: text,
                          qrKey: _qrKey,
                          onMessage: _showMessage,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
