// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get onbTitle1 => 'Свежий хлеб каждое утро';

  @override
  String get onbTitle2 => 'Важно знать!';

  @override
  String get onbTitle3 => 'Как это работает?';

  @override
  String get onbSubtitle1 =>
      'Мы доставляем свежий хлеб прямо к вашей двери каждый день с 7:00 до 10:00';

  @override
  String get onbSubtitle2 =>
      'В приложении можно заказать только хлеб. Другие товары недоступны для онлайн-заказа.';

  @override
  String get onbSubtitle3 =>
      '1. Выберите количество хлеба 2. Укажите адрес доставки 3. Выберите время (07:00-10:00) 4. Оплата при получении';

  @override
  String get continue1 => 'Далее';
}
