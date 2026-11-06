import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._(this._prefs);
  final SharedPreferences _prefs;

  static const _kOpenCount = 'open_count';

  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }

  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  Future<void> increaseOpenCount() async {
    final saved = await _prefs.setInt(_kOpenCount, openCount + 1);
    if (!saved) {
      throw StateError('Penghitung pembukaan aplikasi gagal disimpan.');
    }
  }

  static const _kDarkMode = 'is_dark_mode';

  // ---------- Tema ----------
  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;

  Future<void> setDarkMode(bool value) async {
    final saved = await _prefs.setBool(_kDarkMode, value);
    if (!saved) {
      throw StateError('Pengaturan mode gelap gagal disimpan.');
    }
  }
}
