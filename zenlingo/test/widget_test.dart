import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zenlingo/main.dart';

void main() {
  testWidgets('ZenApp smoke test renders nav shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ZenApp()));

    // The first page shows the 今日 placeholder
    expect(find.text('今日'), findsOneWidget);
  });
}
