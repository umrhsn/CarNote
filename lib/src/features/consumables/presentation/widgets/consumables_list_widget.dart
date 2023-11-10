import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
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
  void initState() {
    widget.list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox)!;

    return Expanded(
      flex: AppDimens.flex1000,
      child: widget.list!.isEmpty
          ? EmptyListWidget(list: widget.list)
          : Scrollbar(
              interactive: true,
              thumbVisibility: false,
              trackVisibility: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: AppDimens.padding10, bottom: AppDimens.padding15, end: AppDimens.padding10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(AppDimens.borderRadius15)),
                  child: ReorderableListView.builder(
                      key: AppKeys.keyList,
                      itemCount: Consumable.getCount(),
                      itemBuilder: (context, index) {
                        widget.list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox)!;
                        Consumable item = widget.list![index];
                        return AnimationConfiguration.staggeredList(
                          key: ValueKey(index),
                          position: index,
                          duration: const Duration(milliseconds: AppNums.durationCardAnimation),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ConsumableItemWidget(key: index == 0 ? AppKeys.keyCard : null, index: index, name: item.name),
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) => setState(() => DatabaseHelper.changeConsumableOrder(context, oldIndex, newIndex))),
                ),
              ),
            ),
    );
  }
}
