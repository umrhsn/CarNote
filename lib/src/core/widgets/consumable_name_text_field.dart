import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

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

    return SizedBox(
      height: 48,
      child: TextField(
        controller: cubit.consumableNameController,
        decoration: InputDecoration(
          filled: false,
          hintText: widget.index == null ? AppStrings.nameHint(context) : DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![widget.index!].name,
          hintStyle: TextStyle(
            fontFamily: AppStrings.fontFamilyEn,
            fontWeight: FontWeight.normal,
            color: context.isLight ? AppColors.hintLight : AppColors.hintDark,
          ),
          labelStyle: TextStyle(color: context.isLight ? AppColors.hintLight : AppColors.hintDark),
          focusColor: context.isLight
              ? AppColors.appBarFocusedPrimaryLight
              : AppColors.appBarFocusedPrimaryDark,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.isLight ? AppColors.hintLight : AppColors.hintDark,
              width: 1.2,
              strokeAlign: 0,
            ),
          ),
          disabledBorder: null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.isLight
                  ? AppColors.appBarFocusedPrimaryLight
                  : AppColors.appBarFocusedPrimaryDark,
              strokeAlign: 0,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
