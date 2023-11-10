import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedButton extends StatefulWidget {
  final String text;
  bool btnEnabled;
  final void Function()? onPressed;

  AnimatedButton({
    super.key,
    required this.text,
    this.btnEnabled = true,
    required this.onPressed,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: AppNums.durationForwardButtonAnimation));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: AppNums.tweenBegin, end: AppNums.tweenEnd).animate(_animationController),
      child: ElevatedButton(
        onPressed: widget.btnEnabled
            ? () {
                _animationController.forward();
                Future.delayed(const Duration(milliseconds: AppNums.durationReverseButtonAnimation), () => _animationController.reverse());
                widget.onPressed!();
              }
            : null,
        style: !widget.btnEnabled
            ? ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(AppColors.getBtnDisabledForeground(context)),
                backgroundColor: MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)),
                fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, AppDimens.elevatedButtonHeight)),
              )
            : ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, AppDimens.elevatedButtonHeight)),
              ),
        child: Text(widget.text),
      ),
    );
  }
}
