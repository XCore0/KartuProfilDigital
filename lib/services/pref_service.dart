import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_data.dart';

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

  static const _kProfile = 'profile_data';

  // ---------- Profil ----------
  ProfileData get profile {
    final raw = _prefs.getString(_kProfile);
    if (raw == null) return ProfileData.defaults;
    return ProfileData.fromJson(raw);
  }

  Future<void> saveProfile(ProfileData profile) async {
    final saved = await _prefs.setString(_kProfile, profile.toJson());
    if (!saved) {
      throw StateError('Perubahan profil gagal disimpan.');
    }
  }

  Future<void> clearProfile() => _prefs.remove(_kProfile);
}
