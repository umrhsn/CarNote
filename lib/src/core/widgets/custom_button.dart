import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  bool btnEnabled;
  final void Function()? onPressed;

  CustomButton({
    Key? key,
    required this.text,
    required this.btnEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.9).animate(_animationController),
      child: ElevatedButton(
        onPressed: widget.btnEnabled
            ? () {
                _animationController.forward();
                Future.delayed(
                    const Duration(milliseconds: 200), () => _animationController.reverse());
                widget.onPressed!();
              }
            : null,
        style: !widget.btnEnabled
            ? ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                foregroundColor:
                    MaterialStateProperty.all(AppColors.getBtnDisabledForeground(context)),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)),
                fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 60)),
              )
            : ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 60)),
              ),
        child: Text(widget.text),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
