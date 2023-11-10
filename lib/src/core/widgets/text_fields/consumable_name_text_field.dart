import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConsumableNameTextField extends StatefulWidget {
  int? index;

  ConsumableNameTextField({super.key, this.index});

  @override
  State<ConsumableNameTextField> createState() => _ConsumableNameTextFieldState();
}

class _ConsumableNameTextFieldState extends State<ConsumableNameTextField> {
  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    return Column(
      children: [
        TextFormField(
          controller: cubit.consumableNameController,
          onEditingComplete: () => widget.index == null ? CustomTextFormField.requestFocus(context, cubit.lastChangedFocus) : null,
          decoration: InputDecoration(
            filled: false,
            hintText:
                widget.index == null ? AppStrings.nameHint(context) : DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![widget.index!].name,
            hintStyle: TextStyle(fontWeight: FontWeight.normal, color: context.isLight ? AppColors.hintLight : AppColors.hintDark),
            labelStyle: TextStyle(color: context.isLight ? AppColors.hintLight : AppColors.hintDark),
            focusColor: context.isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: context.isLight ? AppColors.hintLight : AppColors.hintDark, width: 1.2, strokeAlign: 0)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.isLight ? AppColors.hintLight : AppColors.hintDark, width: 1.2, strokeAlign: 0)),
            disabledBorder: null,
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.isLight ? AppColors.errorLight : AppColors.errorDark, width: 2, strokeAlign: 0)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: context.isLight ? AppColors.errorLight : AppColors.errorDark, width: 1.2, strokeAlign: 0)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: context.isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark, strokeAlign: 0, width: 1.2)),
          ),
          validator: (value) {
            if (cubit.consumableNameController.text.isEmpty) {
              return AppStrings.nameNotEmpty(context);
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: widget.index == null ? TextInputAction.next : TextInputAction.done,
        ),
      ],
    );
  }
}
