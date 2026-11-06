// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kartu_profil_digital/main.dart';
import 'package:kartu_profil_digital/services/pref_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('menampilkan kartu profil Ihsan Hadi Nugroho', (
    WidgetTester tester,
  ) async {
    final prefs = await PrefService.init();
    await prefs.increaseOpenCount();

    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('Kartu Profil Digital'), findsOneWidget);
    expect(find.text('Ihsan Hadi Nugroho'), findsOneWidget);
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Kartu ini sudah dibuka 1 kali'), findsOneWidget);
    expect(
      find.text('Suka membangun aplikasi mobile dan berbagi ilmu.'),
      findsOneWidget,
    );
  });

  test(
    'penghitung bertambah dan tersimpan setelah aplikasi dibuka ulang',
    () async {
      var prefs = await PrefService.init();
      await prefs.increaseOpenCount();
      expect(prefs.openCount, 1);

      prefs = await PrefService.init();
      await prefs.increaseOpenCount();
      expect(prefs.openCount, 2);
    },
  );
}
