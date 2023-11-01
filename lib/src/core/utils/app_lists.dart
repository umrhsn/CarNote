import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/intro/domain/entities/onboarding_page.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/cupertino.dart';

class AppLists {
  /// Localizations
  static List<String> _translateList(BuildContext context, String stringKey) => AppLocalizations.of(context)!.translateList(stringKey)!;

  static List<String> get consumables => LocaleCubit.currentLangCode == AppStrings.ar ? consumablesArabicList : consumablesEnglishList;

  static final List<String> consumablesEnglishList = [
    'Engine Oil',
    'Engine Oil Filter',
    'Timing Belt',
    'Dynamo Belt',
    'Fuel Filter',
    'Air Filter',
    'AC Filter',
    'AC belt',
    'Gearbox Oil',
    'Antifreeze Coolant',
    'Spark Plugs',
    'Brake Linings'
  ];

  static final List<String> consumablesArabicList = [
    'زيت المحرك',
    'فلتر زيت المحرك',
    'سير الكاتينة',
    'سير الدينامو',
    'فلتر البنزين',
    'فلتر الهواء',
    'فلتر التكييف',
    'سير التكييف',
    'زيت الفتيس',
    'مياه التبريد',
    'البوچيهات',
    'تيل الفرامل'
  ];

  static List<DashboardItem> dashboardItems(BuildContext context) =>
      List.generate(
        AssetManager.warningSymbols.length,
        (index) => DashboardItem(
          category: 1,
          image: AssetManager.warningSymbols[index],
          title: _warningTitles(context)[index],
          description: _warningDescriptions(context)[index],
          advice: _warningAdvices(context)[index],
          severity: _warningSeverities[index],
        ),
      ) +
      List.generate(
        AssetManager.advisorySymbols.length,
        (index) => DashboardItem(
          category: 2,
          image: AssetManager.advisorySymbols[index],
          title: _advisoryTitles(context)[index],
          description: _advisoryDescriptions(context)[index],
          advice: _advisoryAdvices(context)[index],
          severity: _advisorySeverities[index],
        ),
      ) +
      List.generate(
        AssetManager.infoSymbols.length,
        (index) => DashboardItem(
          category: 3,
          image: AssetManager.infoSymbols[index],
          title: _infoTitles(context)[index],
          description: _infoDescriptions(context)[index],
          advice: _infoAdvices(context)[index],
          severity: _infoSeverities[index],
        ),
      );

  static List<String> _warningTitles(BuildContext context) => _translateList(context, AppKeys.warning_titles);

  static List<String> _advisoryTitles(BuildContext context) => _translateList(context, AppKeys.advisory_titles);

  static List<String> _infoTitles(BuildContext context) => _translateList(context, AppKeys.info_titles);

  static List<String> _warningDescriptions(BuildContext context) => _translateList(context, AppKeys.warning_descriptions);

  static List<String> _advisoryDescriptions(BuildContext context) => _translateList(context, AppKeys.advisory_descriptions);

  static List<String> _infoDescriptions(BuildContext context) => _translateList(context, AppKeys.info_descriptions);

  static List<String> _warningAdvices(BuildContext context) => _translateList(context, AppKeys.warning_advices);

  static List<String> _advisoryAdvices(BuildContext context) => _translateList(context, AppKeys.advisory_advices);

  static List<String> _infoAdvices(BuildContext context) => _translateList(context, AppKeys.info_advices);

  static final List<int> _warningSeverities = [9, 9, 9, 8, 8, 7, 4, 7, 3, 8, 9, 9, 9, 9, 1, 1, 2, 4, 9, 1, 1, 7, 7, 8, 9, 7, 7, 9];
  static final List<int> _advisorySeverities = [
    9,
    7,
    9,
    9,
    7,
    1,
    7,
    3,
    8,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    4,
    6,
    1,
    8,
    3,
    2,
    7,
    4,
    4,
    7,
    2,
    6,
    3,
    8,
    3,
    9,
    1,
    7,
    6,
    4,
    7,
    7,
    7,
    1,
    1,
    1,
    1,
    1,
    7,
    4
  ];
  static final List<int> _infoSeverities = [
    2,
    2,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    2,
    4,
    4,
    4,
    4,
    1,
    1,
    3,
    3,
    1,
    1,
    2,
    2,
    2,
    2,
    1,
    1,
    2,
    1,
    1,
    1,
    2,
    2,
    2,
    3,
    2,
    2
  ];

  /// OnboardingScreen
  static final int onboardingPagesCount = AssetManager.onboarding.length ~/ 4; // 16 / 4 = 4

  static List<OnboardingPage> onboardingPages(BuildContext context) => List.generate(
        onboardingPagesCount,
        (index) => OnboardingPage(
          title: _translateList(context, AppKeys.onboarding_titles)[index],
          subtitle: _translateList(context, AppKeys.onboarding_subtitles)[index],
          image: LocaleCubit.currentLangCode == AppStrings.ar
              ? context.isLight
                  ? AssetManager.onboarding[index]
                  : AssetManager.onboarding[index + 8]
              : context.isLight
                  ? AssetManager.onboarding[index + 4]
                  : AssetManager.onboarding[index + 12],
        ),
      );

  // FIXME: these methods were functional before switching lists to json files
  static void sortAlphabetically(BuildContext context) => dashboardItems(context).sort((a, b) => a.title.compareTo(b.title));

  static void sortCategories(BuildContext context) {
    sortAlphabetically(context);
    dashboardItems(context).sort((a, b) => a.category.compareTo(b.category));
  }

  static void sortSeverities(BuildContext context) {
    sortCategories(context);
    dashboardItems(context).sort((a, b) => b.severity.compareTo(a.severity));
  }
}
