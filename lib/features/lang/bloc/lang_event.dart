part of 'lang_bloc.dart';

@immutable
sealed class LangEvent {}

final class GetLanguage extends LangEvent {}

final class SetLanguage extends LangEvent {
  SetLanguage({required this.locale});

  final String locale;
}
