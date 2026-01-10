import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/lang_repository.dart';

part 'lang_event.dart';

class LangBloc extends Bloc<LangEvent, Locale> {
  final LangRepository _repository;

  LangBloc({required LangRepository repository})
      : _repository = repository,
        super(Locale(PlatformDispatcher.instance.locale.languageCode)) {
    on<LangEvent>(
      (event, emit) => switch (event) {
        GetLanguage() => _getLanguage(event, emit),
        SetLanguage() => _setLanguage(event, emit),
      },
    );
  }

  void _getLanguage(
    GetLanguage event,
    Emitter<Locale> emit,
  ) {
    final locale = _repository.getLocale();
    emit(Locale(locale));
  }

  void _setLanguage(
    SetLanguage event,
    Emitter<Locale> emit,
  ) async {
    await _repository.setLocale(event.locale);
    add(GetLanguage());
  }
}
