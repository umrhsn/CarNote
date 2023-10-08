import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations_setup.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'src/config/routes/app_routes.dart';
import 'src/config/themes/app_theme.dart';
import 'package:car_note/injection_container.dart' as di;

class CarNote extends StatelessWidget {
  const CarNote({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FormValidation(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => di.sl<CarCubit>()),
          BlocProvider(create: (context) => di.sl<ConsumableCubit>()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previousState, currentState) => previousState != currentState,
          builder: (context, state) => ScreenUtilInit(
            builder: (context, child) => MaterialApp(
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              theme: AppThemes.appTheme(isLight: true),
              darkTheme: AppThemes.appTheme(isLight: false),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
            ),
          ),
        ),
      ),
    );
  }
}
