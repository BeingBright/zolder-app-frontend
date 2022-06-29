import 'package:flutter_test/flutter_test.dart';
import 'package:zolder_app/main.dart';
import 'package:zolder_app/views/login_page.dart';

void main() {
  testWidgets('Hello World', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
