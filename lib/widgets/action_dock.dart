import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/qr_one_controller.dart';
import '../utils/app_strings.dart';

class ActionDock extends ConsumerWidget {
  const ActionDock({
    required this.text,
    required this.qrKey,
    required this.onMessage,
    super.key,
  });

  final AppStrings text;
  final GlobalKey qrKey;
  final ValueChanged<String> onMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qrOneProvider);
    final enabled = state.qrData.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: enabled ? () => _copyPayload(state.qrData) : null,
            icon: const Icon(Icons.copy_rounded),
            label: Text(text.copy),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.tonalIcon(
            onPressed: enabled ? _shareQr : null,
            icon: const Icon(Icons.ios_share_rounded),
            label: Text(text.share),
          ),
        ),
      ],
    );
  }

  Future<void> _copyPayload(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
    onMessage(text.copied);
  }

  Future<void> _shareQr() async {
    try {
      final boundary =
          qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData?.buffer.asUint8List();
      if (bytes == null) return;

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/qr-one.png');
      await file.writeAsBytes(bytes, flush: true);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'image/png')],
          text: text.shareText,
        ),
      );
    } catch (_) {
      onMessage(text.shareFailed);
    }
  }
}
