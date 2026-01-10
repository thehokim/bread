import 'dart:developer';

import 'package:bread_app/features/lang/bloc/lang_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/logo.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/text_gradient.dart';
import '../../home/screens/home_screen.dart';
import '../data/onboard_repository.dart';
import '../../lang/models/language.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final pageController = PageController();

  int index = 0;

  void onNext() {
    if (index == 2) {
      if (mounted) {
        context.read<OnboardRepository>().removeOnboard();
        context.replace(HomeScreen.routePath);
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
      setState(() {
        index++;
      });
    }
  }

  void onPageChanged(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    List<Color> gradient = switch (index) {
      1 => [
          const Color(0xffAD46FF),
          const Color(0xffF6339A),
        ],
      2 => [
          const Color(0xff00C950),
          const Color(0xff00BC7D),
        ],
      _ => [
          const Color(0xffFF6900),
          const Color(0xffFE9A00),
        ],
    };

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: [
              _Content(
                  asset: Assets.onb1,
                  title: l.onbTitle1,
                  subtitle: l.onbSubtitle1,
                  gradient: gradient),
              _Content(
                asset: Assets.onb1,
                title: l.onbTitle2,
                subtitle: l.onbSubtitle2,
                gradient: gradient,
              ),
              _Content(
                asset: Assets.onb1,
                title: l.onbTitle3,
                subtitle: l.onbSubtitle3,
                gradient: gradient,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Logo(size: 40),
                    const SizedBox(width: 8),
                    const GradientText(
                      'doim.uz',
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffF54900),
                          Color(0xffE17100),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.w700,
                      ),
                    ),
                    const Spacer(),
                    _Language(lang: langs.first),
                  ],
                ),
                const Spacer(flex: 3),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (value) {
                      pageController.jumpToPage(value);
                      setState(() {
                        index = value;
                      });
                    },
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      dotColor: const Color(0xffD1D5DC),
                      activeDotColor: gradient.first,
                    ),
                  ),
                ),
                const Spacer(),
                MainButton(
                  title: l.continue1,
                  gradient: gradient,
                  onPressed: onNext,
                ),
                const SizedBox(height: 56),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.asset,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  final String asset;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 240),
        Container(
          height: 144,
          width: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient,
            ),
          ),
          child: Center(
            child: SvgWidget(asset),
          ),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xff101828),
              fontSize: 30,
              fontFamily: AppFonts.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff4A5565),
              fontSize: 16,
              fontFamily: AppFonts.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _Language extends StatelessWidget {
  const _Language({
    required this.lang,
  });

  final Lang lang;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: const Color(0xffFFD6A7),
        ),
      ),
      child: BlocBuilder<LangBloc, Locale>(
        builder: (context, locale) {
          log(locale.languageCode);
          return _Lang(
            lang: langs.firstWhere(
              (element) {
                return element.locale == locale.languageCode;
              },
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Stack(
                    children: [
                      Positioned(
                        right: 16,
                        top: 72,
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: langs.map(
                              (lang) {
                                return _Lang(
                                  lang: lang,
                                  onPressed: () {
                                    context.pop();
                                    context
                                        .read<LangBloc>()
                                        .add(SetLanguage(locale: lang.locale));
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _Lang extends StatelessWidget {
  const _Lang({
    required this.lang,
    required this.onPressed,
  });

  final Lang lang;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      child: Row(
        children: [
          const SizedBox(width: 4),
          Text(lang.flag),
          const SizedBox(width: 4),
          Text(
            lang.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: AppFonts.w500,
            ),
          ),
        ],
      ),
    );
  }
}
