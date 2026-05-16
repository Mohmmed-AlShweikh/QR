import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/input_kind.dart';
import '../services/qr_one_controller.dart';
import '../utils/app_strings.dart';

class InputPanel extends ConsumerStatefulWidget {
  const InputPanel({required this.text, super.key});

  final AppStrings text;

  @override
  ConsumerState<InputPanel> createState() => _InputPanelState();
}

class _InputPanelState extends ConsumerState<InputPanel> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(qrOneProvider);
    final controller = ref.read(qrOneProvider.notifier);
    final text = widget.text;

    if (_textController.text != state.value) {
      _textController.value = TextEditingValue(
        text: state.value,
        selection: TextSelection.collapsed(offset: state.value.length),
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: InputKind.values.map((kind) {
              return ChoiceChip(
                selected: state.inputKind == kind,
                avatar: Icon(_iconFor(kind), size: 18),
                label: Text(text.kind(kind)),
                onSelected: (_) => controller.setInputKind(kind),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          if (state.inputKind != InputKind.image) ...[
            TextField(
              controller: _textController,
              minLines: state.inputKind == InputKind.text ? 5 : 1,
              maxLines: state.inputKind == InputKind.text ? 7 : 2,
              keyboardType: _keyboardFor(state.inputKind),
              textInputAction: TextInputAction.done,
              inputFormatters: _formattersFor(state.inputKind),
              onChanged: controller.setValue,
              decoration: InputDecoration(
                labelText: text.inputLabel(state.inputKind),
                prefixIcon: Icon(_iconFor(state.inputKind)),
              ),
            ),
          ],
          if (state.inputKind == InputKind.image) ...[
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _pickImage(ref),
                    icon: const Icon(Icons.add_photo_alternate_rounded),
                    label: Text(text.pickImage),
                  ),
                ),
                if (state.imagePath != null) ...[
                  const SizedBox(width: 10),
                  IconButton.filledTonal(
                    tooltip: text.removeImage,
                    onPressed: controller.clearImage,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  IconData _iconFor(InputKind kind) {
    return switch (kind) {
      InputKind.text => Icons.notes_rounded,
      InputKind.link => Icons.link_rounded,
      InputKind.phone => Icons.phone_iphone_rounded,
      InputKind.image => Icons.image_rounded,
    };
  }

  TextInputType _keyboardFor(InputKind kind) {
    return switch (kind) {
      InputKind.link => TextInputType.url,
      InputKind.phone => TextInputType.number,
      InputKind.text || InputKind.image => TextInputType.multiline,
    };
  }

  List<TextInputFormatter> _formattersFor(InputKind kind) {
    return switch (kind) {
      InputKind.phone => [FilteringTextInputFormatter.digitsOnly],
      InputKind.link => [
        FilteringTextInputFormatter.allow(
          RegExp(r"[a-zA-Z0-9:/?#[\]@!$&'()*+,;=._~%-]"),
        ),
      ],
      InputKind.text || InputKind.image => const [],
    };
  }

  Future<void> _pickImage(WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
      maxWidth: 1200,
    );
    if (picked != null) {
      ref.read(qrOneProvider.notifier).setImage(picked);
    }
  }
}
