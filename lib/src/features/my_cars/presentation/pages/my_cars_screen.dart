import 'package:car_note/src/core/widgets/ads/banner_ad_widget.dart';
import 'package:car_note/src/core/widgets/buttons/switch_lang_button_widget.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/my_cars_screen_widget.dart';
import 'package:flutter/material.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = LocaleCubit.get(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const MyCarsScreenWidget(),
          SwitchLangButtonWidget(localeCubit: localeCubit),
        ],
      ),
    );
  }
}
