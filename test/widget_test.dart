import 'package:flutter_test/flutter_test.dart';
import 'package:zolder_app/main.dart';
import 'package:zolder_app/views/home_page.dart';

void main() {
  testWidgets('Hello World', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(HomePage), findsOneWidget);
  });
}
