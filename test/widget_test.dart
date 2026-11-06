// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:kartu_profil_digital/main.dart';

void main() {
  testWidgets('menampilkan kartu profil Ihsan Hadi Nugroho',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Kartu Profil Digital'), findsOneWidget);
    expect(find.text('Ihsan Hadi Nugroho'), findsOneWidget);
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(
      find.text('Suka membangun aplikasi mobile dan berbagi ilmu.'),
      findsOneWidget,
    );
  });
}
