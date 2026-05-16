import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qr_one/main.dart';

void main() {
  testWidgets('QR One renders the single-page generator', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: QrOneApp()));

    expect(find.text('QR One'), findsOneWidget);
    expect(find.text('اكتب النص هنا'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'hello from qr one');
    await tester.pump();

    expect(find.text('الرمز جاهز ويتحدث مباشرة'), findsOneWidget);
  });
}
