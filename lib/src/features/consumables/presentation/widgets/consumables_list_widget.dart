import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_widget.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class ConsumablesListWidget extends StatefulWidget {
  ConsumablesListWidget({super.key, required this.list});

  List? list;

  @override
  State<ConsumablesListWidget> createState() => _ConsumablesListWidgetState();
}

class _ConsumablesListWidgetState extends State<ConsumablesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1000,
      child: widget.list != null && widget.list!.isEmpty
          ? const EmptyListWidget()
          : Scrollbar(
              interactive: true,
              thumbVisibility: false,
              trackVisibility: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, bottom: 15, end: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ReorderableListView.builder(
                      key: AppTourService.keyList,
                      itemCount: Consumable.getCount(),
                      itemBuilder: (context, index) {
                        widget.list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);
                        Consumable item = widget.list![index];
                        return AnimationConfiguration.staggeredList(
                          key: ValueKey(index),
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ConsumableWidget(
                                  key: index == 0 ? AppTourService.keyCard : null,
                                  index: index,
                                  name: item.name),
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) => setState(
                          () => DatabaseHelper.changeConsumableOrder(context, oldIndex, newIndex))),
                ),
              ),
            ),
    );
  }
}
