import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/input_kind.dart';
import '../services/qr_one_controller.dart';
import '../utils/app_strings.dart';

class QrPanel extends ConsumerWidget {
  const QrPanel({required this.qrKey, super.key});

  final GlobalKey qrKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qrOneProvider);
    final text = AppStrings.of(state.language);
    final colors = Theme.of(context).colorScheme;
    final qrData = state.qrData;
    final hasData = qrData.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.58),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 36,
            color: Colors.black.withValues(alpha: 0.10),
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: RepaintBoundary(
                key: qrKey,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: hasData
                        ? QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.circle,
                              color: Color(0xFF062A2A),
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.circle,
                              color: Color(0xFF062A2A),
                            ),
                            embeddedImage:
                                state.inputKind != InputKind.image ||
                                    state.imagePath == null
                                ? null
                                : FileImage(File(state.imagePath!)),
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(58, 58),
                            ),
                            errorCorrectionLevel: QrErrorCorrectLevel.H,
                          )
                        : Center(
                            child: Icon(
                              Icons.qr_code_2_rounded,
                              size: 96,
                              color: const Color(
                                0xFF062A2A,
                              ).withValues(alpha: 0.18),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            hasData ? text.live : text.waiting,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          if (state.inputKind == InputKind.image &&
              state.imageName != null) ...[
            const SizedBox(height: 8),
            Text(
              state.imageName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.62),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
