import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';

abstract interface class LangRepository {
  const LangRepository();

  String getLocale();
  Future<void> setLocale(final String locale);
}

final class LangRepositoryImpl implements LangRepository {
  LangRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  String getLocale() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    List<String> codes = [
      Locales.en,
      Locales.ru,
    ];
    return _prefs.getString(Keys.locale) ??
        (codes.contains(code) ? code : Locales.en);
  }

  @override
  Future<void> setLocale(final String locale) async {
    await _prefs.setString(Keys.locale, locale);
  }
}
