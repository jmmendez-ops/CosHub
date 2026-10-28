import 'package:flutter_test/flutter_test.dart';
import 'package:cos_hub/main.dart';

void main() {
  testWidgets('CosHubApp loads and displays logo smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CosHubApp());
    expect(find.text('COS'), findsOneWidget);
    expect(find.text('HUB'), findsOneWidget);
  });
}
