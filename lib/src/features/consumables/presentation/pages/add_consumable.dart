import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/add_consumable_screen_widgets/bottom_buttons_widget.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/add_consumable_screen_widgets/consumable_data_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddConsumableScreen extends StatefulWidget {
  const AddConsumableScreen({super.key});

  @override
  State<AddConsumableScreen> createState() => AddConsumableScreenState();
}

class AddConsumableScreenState extends State<AddConsumableScreen> {
  void _resetControllersValues() {
    ConsumableCubit cubit = ConsumableCubit.get(context);
    cubit.consumableNameController.text = '';
    cubit.lastChangedController.text = '';
    cubit.changeIntervalController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          _resetControllersValues();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: AppDimens.appBarHeight80,
            title: Text(
              AppStrings.addConsumable(context),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                ConsumableDataCardWidget(cubit: cubit),
                const Spacer(),
                BottomButtonsWidget(cubit: cubit),
                const SizedBox(height: AppDimens.sizedBox15),
                // const BannerAdWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
