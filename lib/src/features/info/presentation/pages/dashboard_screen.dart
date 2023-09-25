import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/info/presentation/widgets/dashboard_symbols_card.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const int _gridColumnsCount = 5;
  bool _switchToListView = false;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (AppTourService.shouldBeginTour(
        prefsBoolKey: AppStrings.prefsBoolBeginDashboardScreenTour)) {
      AppTourService.beginDashboardScreenTour(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    LocaleCubit localeCubit = LocaleCubit.get(context);

    Padding buildAppBarIcons() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
            IconButton(
              key: AppTourService.keySwitchLangDashboardScreen,
              icon: const FaIcon(FontAwesomeIcons.language),
              onPressed: () => AppLocalizations.of(context)!.isEnLocale
                  ? localeCubit.toArabic(context)
                  : localeCubit.toEnglish(context),
              tooltip: AppStrings.switchLangTooltip(context),
            ),
            IconButton(
              key: AppTourService.keySwitchListGrid,
              icon: Icon(_switchToListView ? Icons.grid_view_rounded : Icons.sort_rounded),
              onPressed: () {
                setState(() {
                  _selectedIndex = null;
                  _switchToListView = !_switchToListView;
                });
                BotToast.showText(
                    text: _switchToListView
                        ? AppStrings.switchedToListView(context)
                        : AppStrings.switchedToGridView(context));
              },
              tooltip: _switchToListView
                  ? AppStrings.switchToGridView(context)
                  : AppStrings.switchToListView(context),
            ),
            // FIXME: these methods were functional before switching lists to json files
            // IconButton(
            //   icon: const Icon(Icons.sort_by_alpha_rounded),
            //   onPressed: () => setState(() => AppStrings.sortAlphabetically(context)),
            //   tooltip: AppStrings.sortByAlphaTooltip(context),
            // ),
            // IconButton(
            //   icon: const Icon(Icons.category_outlined),
            //   onPressed: () => setState(() => AppStrings.sortCategories(context)),
            //   tooltip: AppStrings.sortByCategoryTooltip(context),
            // ),
            // IconButton(
            //   icon: const Icon(Icons.warning_amber_rounded),
            //   onPressed: () => setState(() => AppStrings.sortSeverities(context)),
            //   tooltip: AppStrings.sortBySeverityTooltip(context),
            // ),
          ],
        ),
      );
    }

    IntrinsicHeight buildAppBarWidgets() => IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                buildAppBarIcons(),
                _selectedIndex == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DashboardSymbolsCard(
                          detailed: true,
                          onTap: () => setState(() => _selectedIndex = null),
                          reverseDirection: false,
                          image: AppStrings.dashboardItems(context)[_selectedIndex!].image,
                          title: AppStrings.dashboardItems(context)[_selectedIndex!].title,
                          description:
                              AppStrings.dashboardItems(context)[_selectedIndex!].description,
                          advice: AppStrings.dashboardItems(context)[_selectedIndex!].advice,
                          severity: AppStrings.dashboardItems(context)[_selectedIndex!].severity,
                        ),
                      ),
              ],
            ),
          ),
        );

    ClipRRect buildGrid() => ClipRRect(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: GridView.builder(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
            itemCount: AppStrings.dashboardItems(context).length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _gridColumnsCount),
            itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: _gridColumnsCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: DashboardSymbolsCard(
                    key: index == 0 ? AppTourService.keyGridItem : null,
                    onTap: () => setState(() => _selectedIndex = index),
                    detailed: _switchToListView,
                    reverseDirection: index % 2 == 0 ? false : true,
                    image: AppStrings.dashboardItems(context)[index].image,
                    title: AppStrings.dashboardItems(context)[index].title,
                    description: AppStrings.dashboardItems(context)[index].description,
                    advice: AppStrings.dashboardItems(context)[index].advice,
                    severity: AppStrings.dashboardItems(context)[index].severity,
                  ),
                ),
              ),
            ),
          ),
        );

    ClipRRect buildList() => ClipRRect(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: ListView.builder(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
            itemCount: AppStrings.dashboardItems(context).length,
            itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: DashboardSymbolsCard(
                    detailed: _switchToListView,
                    reverseDirection: index % 2 == 0 ? false : true,
                    image: AppStrings.dashboardItems(context)[index].image,
                    title: AppStrings.dashboardItems(context)[index].title,
                    description: AppStrings.dashboardItems(context)[index].description,
                    advice: AppStrings.dashboardItems(context)[index].advice,
                    severity: AppStrings.dashboardItems(context)[index].severity,
                  ),
                ),
              ),
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildAppBarWidgets(),
            Expanded(
              child: Scrollbar(
                interactive: true,
                thumbVisibility: false,
                trackVisibility: false,
                child: AnimationLimiter(
                  child: !_switchToListView ? buildGrid() : buildList(),
                ),
              ),
            ),
            // const BannerAdWidget()
          ],
        ),
      ),
    );
  }
}
