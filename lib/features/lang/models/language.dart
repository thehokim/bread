final class Lang {
  Lang({
    required this.locale,
    required this.title,
    required this.flag,
  });

  final String locale;
  final String title;
  final String flag;
}

final langs = [
  Lang(locale: 'ru', title: 'Русский', flag: '🇷🇺'),
  Lang(locale: 'en', title: 'O\'zbekcha', flag: '🇺🇿'),
];
