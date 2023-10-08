import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/widgets/text_fields/consumable_name_text_field.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/add_consumable_screen_widgets/change_interval_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/add_consumable_screen_widgets/last_changed_text_form_field.dart';
import 'package:flutter/material.dart';

class ConsumableDataCardWidget extends StatelessWidget {
  const ConsumableDataCardWidget({
    super.key,
    required this.cubit,
  });

  final ConsumableCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.padding20),
          child: Column(
            children: [
              ConsumableNameTextField(),
              const SizedBox(height: AppDimens.sizedBox20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastChangedTextFormField(cubit: cubit),
                  ChangeIntervalTextFormField(cubit: cubit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}