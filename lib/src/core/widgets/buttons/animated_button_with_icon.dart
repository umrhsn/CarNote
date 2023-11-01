import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedButtonWithIcon extends StatefulWidget {
  final IconData icon;
  bool btnEnabled;
  final void Function()? onPressed;

  AnimatedButtonWithIcon({
    super.key,
    required this.icon,
    this.btnEnabled = true,
    required this.onPressed,
  });

  @override
  State<AnimatedButtonWithIcon> createState() => _AnimatedButtonWithIconState();
}

class _AnimatedButtonWithIconState extends State<AnimatedButtonWithIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.9).animate(_animationController),
      child: ElevatedButton(
        onPressed: widget.btnEnabled
            ? () {
                _animationController.forward();
                Future.delayed(const Duration(milliseconds: 200), () => _animationController.reverse());
                widget.onPressed!();
              }
            : null,
        style: !widget.btnEnabled
            ? ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(AppColors.getBtnDisabledForeground(context)),
                backgroundColor: MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)),
                fixedSize: MaterialStateProperty.all(const Size(60, 60)),
              )
            : ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                fixedSize: MaterialStateProperty.all(const Size(60, 60)),
              ),
        child: Icon(widget.icon),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
