import 'package:car_note/src/core/services/form_validation/validation_item.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final ValidationItem? validationItem;
  final void Function(String? value)? validateItemForm;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextStyle? style;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.center,
    this.inputFormatters,
    this.onEditingComplete,
    this.validationItem,
    this.validateItemForm,
    this.onFieldSubmitted,
    this.validator,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.padding8),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        textAlign: textAlign,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: validationItem!.error,
          errorStyle: TextStyle(
            color: AppColors.getErrorColor(context),
            fontFamily: LocaleCubit.currentLangCode == AppStrings.en ? AppStrings.fontFamilyEn : AppStrings.fontFamilyAr,
          ),
        ),
        onChanged: (String? value) => validateItemForm!(value),
        onFieldSubmitted: onFieldSubmitted,
        style: style,
        onEditingComplete: onEditingComplete,
        validator: validator,
      ),
    );
  }

  static void requestFocus(BuildContext context, FocusNode? requestedFocusNode) => FocusScope.of(context).requestFocus(requestedFocusNode);
}
