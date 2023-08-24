import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class WarningSymbolsCard extends StatefulWidget {
  void Function()? onTap;
  final bool detailed;
  final bool reverseDirection;
  final String image;
  final String title;
  final String? description;
  final String? advice;
  final int severity;

  WarningSymbolsCard({
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

  @override
  State<WarningSymbolsCard> createState() => _WarningSymbolsCardState();
}

class _WarningSymbolsCardState extends State<WarningSymbolsCard> {
  final TextDirection _direction =
      LocaleCubit.currentLangCode == 'en' ? TextDirection.ltr : TextDirection.rtl;

  final TextDirection _directionReversed =
      LocaleCubit.currentLangCode == 'en' ? TextDirection.rtl : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: widget.onTap,
      child: !widget.detailed
          ? Card(
        elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(widget.image),
              ),
            )
          : Directionality(
              textDirection: widget.reverseDirection ? _directionReversed : _direction,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Image.asset(widget.image)),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 6,
                        child: Directionality(
                          textDirection: _direction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
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
                                    widget.description == null
                                        ? const SizedBox()
                                        : Text(
                                            widget.description ?? '',
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontFamily: AppStrings.fontFamilyEn),
                                          ),
                                    widget.description == null
                                        ? const SizedBox()
                                        : const SizedBox(height: 10),
                                    widget.advice == null
                                        ? const SizedBox()
                                        : const Text(
                                            "Advice:",
                                            style: TextStyle(
                                                fontFamily: AppStrings.fontFamilyEn,
                                                fontWeight: FontWeight.bold),
                                          ),
                                    widget.advice == null
                                        ? const SizedBox()
                                        : Text(
                                            widget.advice ?? '',
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontFamily: AppStrings.fontFamilyEn),
                                          ),
                                    widget.advice == null
                                        ? const SizedBox()
                                        : const SizedBox(height: 10),
                                    const Text(
                                      "Severity:",
                                      style: TextStyle(
                                          fontFamily: AppStrings.fontFamilyEn,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${widget.severity}/10',
                                      softWrap: true,
                                      style: const TextStyle(fontFamily: AppStrings.fontFamilyEn),
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
    );
  }
}
