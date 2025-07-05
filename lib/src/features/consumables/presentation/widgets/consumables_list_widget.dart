// lib/src/features/consumables/presentation/widgets/consumables_list_widget.dart
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/consumable_item_widget.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ConsumablesListWidget extends StatefulWidget {
  const ConsumablesListWidget({super.key, required this.consumableCubit});

  final ConsumableCubit consumableCubit;

  @override
  State<ConsumablesListWidget> createState() => _ConsumablesListWidgetState();
}

class _ConsumablesListWidgetState extends State<ConsumablesListWidget> {
  @override
  Widget build(BuildContext context) {
    final consumables = widget.consumableCubit.consumables;

    return Expanded(
      flex: AppDimens.flex1000,
      child: consumables.isEmpty
          ? EmptyListWidget(list: consumables)
          : Scrollbar(
              interactive: true,
              thumbVisibility: false,
              trackVisibility: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: AppDimens.padding10,
                    bottom: AppDimens.padding15,
                    end: AppDimens.padding10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimens.borderRadius15)),
                  child: ReorderableListView.builder(
                      key: AppKeys.keyList,
                      itemCount: consumables.length,
                      itemBuilder: (context, index) {
                        final item = consumables[index];
                        return AnimationConfiguration.staggeredList(
                          key: ValueKey(index),
                          position: index,
                          duration: const Duration(
                              milliseconds: AppNums.durationCardAnimation),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: ConsumableItemWidget(
                                key: index == 0
                                    ? AppKeys.keyCard
                                    : ValueKey('consumable_$index'),
                                index: index,
                                name: item.name,
                                consumableCubit: widget.consumableCubit,
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) => setState(() => widget
                          .consumableCubit
                          .reorderConsumables(context, oldIndex, newIndex))),
                ),
              ),
            ),
    );
  }
}
