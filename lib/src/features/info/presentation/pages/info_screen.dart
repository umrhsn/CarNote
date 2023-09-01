import 'package:car_note/src/core/utils/app_strings.dart';
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
  bool _switchToListView = false;
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
                  icon: Icon(_switchToListView ? Icons.grid_view_outlined : Icons.sort_rounded),
                  onPressed: () => setState(() {
                    _selectedIndex = null;
                    _switchToListView = !_switchToListView;
                  }),
                  tooltip: _switchToListView
                      ? AppStrings.switchToGridView(context)
                      : AppStrings.switchToListView(context),
                ),
                IconButton(
                  icon: const Icon(Icons.sort_by_alpha_rounded),
                  onPressed: () => setState(() => AppStrings.sortAlphabetically(context)),
                  tooltip: AppStrings.sortByAlphaTooltip(context),
                ),
                IconButton(
                  icon: const Icon(Icons.category_outlined),
                  onPressed: () => setState(() => AppStrings.sortCategories(context)),
                  tooltip: AppStrings.sortByCategoryTooltip(context),
                ),
                IconButton(
                  icon: const Icon(Icons.warning_amber_rounded),
                  onPressed: () => setState(() => AppStrings.sortSeverities(context)),
                  tooltip: AppStrings.sortBySeverityTooltip(context),
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
                    image: AppStrings.infoItems(context)[_selectedIndex!].image,
                    title: AppStrings.infoItems(context)[_selectedIndex!].title,
                    description: AppStrings.infoItems(context)[_selectedIndex!].description,
                    advice: AppStrings.infoItems(context)[_selectedIndex!].advice,
                    severity: AppStrings.infoItems(context)[_selectedIndex!].severity,
                  ),
            const Spacer(),
          ],
        ),
      );
    }

    ClipRRect buildGrid() {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: GridView.builder(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
          itemCount: AppStrings.infoItems(context).length,
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
                  detailed: _switchToListView,
                  reverseDirection: index % 2 == 0 ? false : true,
                  image: AppStrings.infoItems(context)[index].image,
                  title: AppStrings.infoItems(context)[index].title,
                  description: AppStrings.infoItems(context)[index].description,
                  advice: AppStrings.infoItems(context)[index].advice,
                  severity: AppStrings.infoItems(context)[index].severity,
                ),
              ),
            ),
          ),
        ),
      );
    }

    ClipRRect buildList() {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: ListView.builder(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
          itemCount: AppStrings.infoItems(context).length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              child: FadeInAnimation(
                child: WarningSymbolsCard(
                  detailed: _switchToListView,
                  reverseDirection: index % 2 == 0 ? false : true,
                  image: AppStrings.infoItems(context)[index].image,
                  title: AppStrings.infoItems(context)[index].title,
                  description: AppStrings.infoItems(context)[index].description,
                  advice: AppStrings.infoItems(context)[index].advice,
                  severity: AppStrings.infoItems(context)[index].severity,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: _selectedIndex == null ? 60 : 400,
        title: buildAppBarWidgets(),
      ),
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 5),
          child: AnimationLimiter(
            child: !_switchToListView ? buildGrid() : buildList(),
          ),
        ),
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
