import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/info/data/info_item_strings.dart';
import 'package:car_note/src/features/info/presentation/widgets/warning_symbols_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  static const int _gridColumnsCount = 5;
  bool _switchToDetailedView = false;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    SizedBox buildAppBarWidgets() {
      return SizedBox(
        height: _selectedIndex == null ? 60 : 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.sort_rounded),
                  onPressed: () => setState(() {
                    _selectedIndex = null;
                    _switchToDetailedView = !_switchToDetailedView;
                  }),
                  tooltip: AppStrings.toggleModeTooltip(context),
                ),
                IconButton(
                  icon: const Icon(Icons.sort_by_alpha_rounded),
                  onPressed: () => setState(() => InfoItemStrings.sortAlphabetically()),
                  tooltip: AppStrings.toggleModeTooltip(context),
                ),
                IconButton(
                  icon: const Icon(Icons.category_outlined),
                  onPressed: () => setState(() => InfoItemStrings.sortCategories()),
                  tooltip: AppStrings.toggleModeTooltip(context),
                ),
                IconButton(
                  icon: const Icon(Icons.warning_amber_rounded),
                  onPressed: () => setState(() => InfoItemStrings.sortSeverities()),
                  tooltip: AppStrings.toggleModeTooltip(context),
                ),
              ],
            ),
            _selectedIndex == null ? const SizedBox() : const Spacer(),
            _selectedIndex == null
                ? const SizedBox()
                : WarningSymbolsCard(
                    detailed: true,
                    onTap: () => setState(() => _selectedIndex = null),
                    reverseDirection: false,
                    image: InfoItemStrings.infoItems[_selectedIndex!].image,
                    title: InfoItemStrings.infoItems[_selectedIndex!].title,
                    description: InfoItemStrings.infoItems[_selectedIndex!].description,
                    advice: InfoItemStrings.infoItems[_selectedIndex!].advice,
                    severity: InfoItemStrings.infoItems[_selectedIndex!].severity,
                  ),
            const Spacer(),
          ],
        ),
      );
    }

    GridView buildGrid() {
      return GridView.builder(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
        itemCount: InfoItemStrings.infoItems.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _gridColumnsCount),
        itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 375),
          columnCount: _gridColumnsCount,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: WarningSymbolsCard(
                onTap: () => setState(() => _selectedIndex = index),
                detailed: _switchToDetailedView,
                reverseDirection: index % 2 == 0 ? false : true,
                image: InfoItemStrings.infoItems[index].image,
                title: InfoItemStrings.infoItems[index].title,
                description: InfoItemStrings.infoItems[index].description,
                advice: InfoItemStrings.infoItems[index].advice,
                severity: InfoItemStrings.infoItems[index].severity,
              ),
            ),
          ),
        ),
      );
    }

    ListView buildList() {
      return ListView.builder(
        padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
        itemCount: InfoItemStrings.infoItems.length,
        itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: WarningSymbolsCard(
                detailed: _switchToDetailedView,
                reverseDirection: index % 2 == 0 ? false : true,
                image: InfoItemStrings.infoItems[index].image,
                title: InfoItemStrings.infoItems[index].title,
                description: InfoItemStrings.infoItems[index].description,
                advice: InfoItemStrings.infoItems[index].advice,
                severity: InfoItemStrings.infoItems[index].severity,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.getPrimaryColor(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: _selectedIndex == null ? 60 : 400,
        title: buildAppBarWidgets(),
      ),
      body: AnimationLimiter(
        child: !_switchToDetailedView ? buildGrid() : buildList(),
      ),
    );
  }
}
// Column(
//   children: List.generate(
//     InfoItemStrings.infoItems.length,
//     (index) => WarningSymbolsCard(
//       reverseDirection: index % 2 == 0 ? false : true,
//       image: InfoItemStrings.infoItems[index].image,
//       title: InfoItemStrings.infoItems[index].title,
//       description: InfoItemStrings.infoItems[index].description,
//       advice: InfoItemStrings.infoItems[index].advice,
//       severity: InfoItemStrings.infoItems[index].severity,
//     ),
//   ),
// ),
