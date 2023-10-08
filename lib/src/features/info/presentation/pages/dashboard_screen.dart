import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_icon_button.dart';
import 'package:car_note/src/features/info/presentation/widgets/dashboard_symbols_card.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    if (AppTourService.shouldBeginTour(prefsBoolKey: AppKeys.prefsBoolBeginDashboardScreenTour)) {
      AppTourService.beginDashboardScreenTour(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    LocaleCubit localeCubit = LocaleCubit.get(context);

    Padding buildAppBarIcons() {
      return Padding(
        padding: const EdgeInsets.only(top: AppDimens.padding10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedIconButton(onPressed: () => Navigator.pop(context), icon: Icons.arrow_back),
            AnimatedIconButton(
              key: AppKeys.keySwitchLangDashboardScreen,
              faIcon: true,
              icon: FontAwesomeIcons.language,
              onPressed: () => AppLocalizations.of(context)!.isEnLocale
                  ? localeCubit.toArabic(context, showToast: true)
                  : localeCubit.toEnglish(context, showToast: true),
              tooltip: AppStrings.switchLangTooltip(context),
            ),
            AnimatedIconButton(
              key: AppKeys.keySwitchListGrid,
              icon: _switchToListView ? Icons.grid_view_rounded : Icons.sort_rounded,
              onPressed: () {
                setState(() {
                  _selectedIndex = null;
                  _switchToListView = !_switchToListView;
                });
                BotToast.showText(text: _switchToListView ? AppStrings.switchedToListView(context) : AppStrings.switchedToGridView(context));
              },
              tooltip: _switchToListView ? AppStrings.switchToGridView(context) : AppStrings.switchToListView(context),
            ),
            // FIXME: these methods were functional before switching lists to json files
            // AnimatedIconButton(
            //   icon: Icons.sort_by_alpha_rounded,
            //   onPressed: () => setState(() => AppStrings.sortAlphabetically(context)),
            //   tooltip: AppStrings.sortByAlphaTooltip(context),
            // ),
            // AnimatedIconButton(
            //   icon: Icon(Icons.category_outlined,
            //   onPressed: () => setState(() => AppStrings.sortCategories(context)),
            //   tooltip: AppStrings.sortByCategoryTooltip(context),
            // ),
            // AnimatedIconButton(
            //   icon: Icons.warning_amber_rounded,
            //   onPressed: () => setState(() => AppStrings.sortSeverities(context)),
            //   tooltip: AppStrings.sortBySeverityTooltip(context),
            // ),
          ],
        ),
      );
    }

    IntrinsicHeight buildAppBarWidgets() => IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
            child: Column(
              children: [
                buildAppBarIcons(),
                _selectedIndex == null
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(bottom: AppDimens.padding10.w),
                        child: DashboardSymbolsCard(
                          detailed: true,
                          onTap: () => setState(() => _selectedIndex = null),
                          reverseDirection: false,
                          image: AppLists.dashboardItems(context)[_selectedIndex!].image,
                          title: AppLists.dashboardItems(context)[_selectedIndex!].title,
                          description: AppLists.dashboardItems(context)[_selectedIndex!].description,
                          advice: AppLists.dashboardItems(context)[_selectedIndex!].advice,
                          severity: AppLists.dashboardItems(context)[_selectedIndex!].severity,
                        ),
                      ),
              ],
            ),
          ),
        );

    ClipRRect buildGrid() => ClipRRect(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(AppDimens.borderRadius30), topRight: Radius.circular(AppDimens.borderRadius30)),
          child: GridView.builder(
            padding: EdgeInsetsDirectional.only(start: AppDimens.padding10.w, end: AppDimens.padding10.w, bottom: AppDimens.padding10.h),
            itemCount: AppLists.dashboardItems(context).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _gridColumnsCount),
            itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: AppNums.durationCardAnimation),
              columnCount: _gridColumnsCount,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: DashboardSymbolsCard(
                    key: index == 0 ? AppKeys.keyGridItem : null,
                    onTap: () => setState(() => _selectedIndex = index),
                    detailed: _switchToListView,
                    reverseDirection: index % 2 == 0 ? false : true,
                    image: AppLists.dashboardItems(context)[index].image,
                    title: AppLists.dashboardItems(context)[index].title,
                    description: AppLists.dashboardItems(context)[index].description,
                    advice: AppLists.dashboardItems(context)[index].advice,
                    severity: AppLists.dashboardItems(context)[index].severity,
                  ),
                ),
              ),
            ),
          ),
        );

    ClipRRect buildList() => ClipRRect(
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(AppDimens.borderRadius30), topRight: Radius.circular(AppDimens.borderRadius30)),
          child: ListView.builder(
            padding: const EdgeInsetsDirectional.only(start: AppDimens.padding10, end: AppDimens.padding10, bottom: AppDimens.padding10),
            itemCount: AppLists.dashboardItems(context).length,
            itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: AppNums.durationCardAnimation),
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: DashboardSymbolsCard(
                    detailed: _switchToListView,
                    reverseDirection: index % 2 == 0 ? false : true,
                    image: AppLists.dashboardItems(context)[index].image,
                    title: AppLists.dashboardItems(context)[index].title,
                    description: AppLists.dashboardItems(context)[index].description,
                    advice: AppLists.dashboardItems(context)[index].advice,
                    severity: AppLists.dashboardItems(context)[index].severity,
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
