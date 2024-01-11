import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/widgets/logo/logo_widget.dart';
import 'package:car_note/src/core/widgets/buttons/switch_lang_button_widget.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/bottom_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.padding20.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoWidget(),
                      SizedBox(height: AppDimens.sizedBox20.r),
                      
                      SizedBox(height: AppDimens.sizedBox15.r),
                      const BottomButtonsWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SwitchLangButtonWidget(localeCubit: localeCubit),
          // const BannerAdWidget(),
        ],
      ),
    );
  }
}
