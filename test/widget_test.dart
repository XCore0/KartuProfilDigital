// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
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

  testWidgets('mengubah dan menyimpan preferensi mode gelap', (
    WidgetTester tester,
  ) async {
    final prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.dark,
    );
    expect(prefs.isDarkMode, isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    final reopenedPrefs = await PrefService.init();
    expect(reopenedPrefs.isDarkMode, isTrue);

    await tester.pumpWidget(MyApp(prefs: reopenedPrefs));
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );
  });

  testWidgets('profil hasil edit tetap ada setelah aplikasi dibuka ulang', (
    WidgetTester tester,
  ) async {
    var prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nama'),
      'Nama Baru',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Jabatan'),
      'Desainer',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Bio'),
      'Bio yang sudah diperbarui.',
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Nama Baru'), findsOneWidget);
    expect(find.text('Desainer'), findsOneWidget);
    expect(find.text('Bio yang sudah diperbarui.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    prefs = await PrefService.init();
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('Nama Baru'), findsOneWidget);
    expect(find.text('Desainer'), findsOneWidget);
    expect(find.text('Bio yang sudah diperbarui.'), findsOneWidget);
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
