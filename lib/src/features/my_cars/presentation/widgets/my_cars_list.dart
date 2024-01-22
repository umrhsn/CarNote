import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/my_cars_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyCarsList extends StatelessWidget {
  const MyCarsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimationLimiter(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(AppDimens.borderRadius15)),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1, // TODO: replace with cars list length
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: AppNums.durationCardAnimation),
                child: const SlideAnimation(
                  child: FadeInAnimation(
                    child: MyCarsListItem(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
