import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DashboardSymbolsCard extends StatelessWidget {
  final void Function()? onTap;
  final bool detailed;
  final bool reverseDirection;
  final String image;
  final String title;
  final String? description;
  final String? advice;
  final int severity;

  DashboardSymbolsCard({
    super.key,
    this.onTap,
    required this.detailed,
    required this.image,
    required this.reverseDirection,
    required this.title,
    required this.description,
    required this.advice,
    required this.severity,
  });

  final TextDirection _direction =
      LocaleCubit.currentLangCode == 'en' ? TextDirection.ltr : TextDirection.rtl;

  final TextDirection _directionReversed =
      LocaleCubit.currentLangCode == 'en' ? TextDirection.rtl : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: !detailed
          ? Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(image),
              ),
            )
          : AnimationConfiguration.synchronized(
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Directionality(
                    textDirection: reverseDirection ? _directionReversed : _direction,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child: Image.asset(image)),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 6,
                              child: Directionality(
                                textDirection: _direction,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: AppStrings.fontFamilyEn,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: _direction,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          description == null
                                              ? const SizedBox()
                                              : Text(
                                                  description ?? '',
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontFamily: AppStrings.fontFamilyEn,
                                                    color: AppColors.getHintColor(context),
                                                  ),
                                                ),
                                          description == null
                                              ? const SizedBox()
                                              : const SizedBox(height: 10),
                                          advice == null
                                              ? const SizedBox()
                                              : Text(
                                                  '${AppStrings.advice(context)}:',
                                                  style: const TextStyle(
                                                      fontFamily: AppStrings.fontFamilyEn,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                          advice == null
                                              ? const SizedBox()
                                              : Text(
                                                  advice ?? '',
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontFamily: AppStrings.fontFamilyEn,
                                                    color: AppColors.getHintColor(context),
                                                  ),
                                                ),
                                          advice == null ? const SizedBox() : const SizedBox(height: 10),
                                          Text(
                                            '${AppStrings.severity(context)}:',
                                            style: const TextStyle(
                                              fontFamily: AppStrings.fontFamilyEn,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            LocaleCubit.currentLangCode == AppStrings.en
                                                ? '$severity / 10'
                                                : '$severity / 10'.toArabicNumerals(),
                                            softWrap: true,
                                            style: TextStyle(
                                              fontFamily: AppStrings.fontFamilyEn,
                                              color: AppColors.getHintColor(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ),
          ),
    );
  }
}