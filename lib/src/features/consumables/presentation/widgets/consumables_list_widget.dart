import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/consumable_item_widget.dart';
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
                padding: EdgeInsetsDirectional.only(
                    start: AppDimens.edge10, bottom: AppDimens.edge15, end: AppDimens.edge10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(AppDimens.borderRadius15)),
                  child: ReorderableListView.builder(
                      key: AppTourService.keyList,
                      itemCount: Consumable.getCount(),
                      itemBuilder: (context, index) {
                        widget.list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);
                        Consumable item = widget.list![index];
                        return AnimationConfiguration.staggeredList(
                          key: ValueKey(index),
                          position: index,
                          duration: const Duration(milliseconds: AppNums.durationCardAnimation),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ConsumableItemWidget(
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
