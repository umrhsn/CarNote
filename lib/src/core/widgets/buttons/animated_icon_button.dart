import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  bool btnEnabled;
  final void Function()? onPressed;
  String? tooltip;
  bool faIcon;

  AnimatedIconButton({
    super.key,
    required this.icon,
    this.btnEnabled = true,
    required this.onPressed,
    this.tooltip,
    this.faIcon = false,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> with TickerProviderStateMixin {
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
      child: IconButton(
        onPressed: widget.btnEnabled
            ? () {
                _animationController.forward();
                Future.delayed(const Duration(milliseconds: AppNums.durationReverseButtonAnimation), () => _animationController.reverse());
                widget.onPressed!();
              }
            : null,
        style: !widget.btnEnabled
            ? ButtonStyle(foregroundColor: MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)))
            : ButtonStyle(foregroundColor: MaterialStateProperty.all(context.isLight ? AppColors.iconLight : AppColors.iconDark)),
        icon: widget.faIcon ? FaIcon(widget.icon) : Icon(widget.icon),
        tooltip: widget.tooltip,
      ),
    );
  }
}
