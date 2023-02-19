import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'src/config/routes/app_routes.dart';
import 'src/config/themes/app_theme.dart';

class CarNote extends StatelessWidget {
  const CarNote({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FormValidation(),
      child: BlocProvider(
        create: (context) => ConsumableCubit(),
        child: MaterialApp(
          theme: AppThemes.appTheme(isLight: true),
          darkTheme: AppThemes.appTheme(isLight: false),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
