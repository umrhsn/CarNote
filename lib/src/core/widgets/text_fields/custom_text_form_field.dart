import 'package:car_note/src/core/services/form_validation/validation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValidationItem? validationItem;
  final void Function(String? value)? validateItemForm;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? style;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validationItem,
    this.validateItemForm,
    this.onFieldSubmitted,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(hintText: hintText, errorText: validationItem!.error),
        onChanged: (String? value) => validateItemForm!(value),
        onFieldSubmitted: onFieldSubmitted,
        style: style,
      ),
    );
  }

  static void requestFocus(BuildContext context, FocusNode? requestedFocusNode) {
    FocusScope.of(context).requestFocus(requestedFocusNode);
  }
}
