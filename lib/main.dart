import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/lang/bloc/lang_bloc.dart';
import 'features/lang/data/lang_repository.dart';
import 'features/onboard/data/onboard_repository.dart';

// final l = AppLocalizations.of(context)!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OnboardRepository>(
          create: (context) => OnboardRepositoryImpl(prefs: prefs),
        ),
        RepositoryProvider<LangRepository>(
          create: (context) => LangRepositoryImpl(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LangBloc(
              repository: context.read<LangRepository>(),
            )..add(GetLanguage()),
          ),
        ],
        child: const BreadApp(),
      ),
    ),
  );
}
