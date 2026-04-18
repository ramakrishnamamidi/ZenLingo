import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/main.dart';

void main() {
  testWidgets('ZenApp smoke test renders nav shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ZenApp()));
    await tester.pump();
    expect(find.byType(ZenApp), findsOneWidget);
  });
}
