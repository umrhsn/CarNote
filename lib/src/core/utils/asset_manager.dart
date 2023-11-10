import 'package:flutter/material.dart';

const String imgPath = 'assets/images';

const String dashboardLightsPath = '$imgPath/dashboard_lights';
const String warningPath = '$dashboardLightsPath/warning';
const String advisoryPath = '$dashboardLightsPath/advisory';
const String infoPath = '$dashboardLightsPath/info';

const String onboardingPath = '$imgPath/onboarding';

class AssetManager {
  static const String icon = '$imgPath/icon.png';

  static Image splashImage() => Image.asset(icon, height: 150);

  static const String nothingHere = '$imgPath/nothing_here.png';

  static const String ar = '$imgPath/ar.png';
  static const String en = '$imgPath/en.png';

  static final List<String> onboarding = [
    '$onboardingPath/onboardingArLight1.jpg', // 0 (index)
    '$onboardingPath/onboardingArLight2.jpg',
    '$onboardingPath/onboardingArLight3.jpg',
    '$onboardingPath/onboardingArLight4.jpg',
    '$onboardingPath/onboardingEnLight1.jpg', // 4 (index + 4)
    '$onboardingPath/onboardingEnLight2.jpg',
    '$onboardingPath/onboardingEnLight3.jpg',
    '$onboardingPath/onboardingEnLight4.jpg',
    '$onboardingPath/onboardingArDark1.jpg', // 8 (index + 8)
    '$onboardingPath/onboardingArDark2.jpg',
    '$onboardingPath/onboardingArDark3.jpg',
    '$onboardingPath/onboardingArDark4.jpg',
    '$onboardingPath/onboardingEnDark1.jpg', // 12 (index + 12)
    '$onboardingPath/onboardingEnDark2.jpg',
    '$onboardingPath/onboardingEnDark3.jpg',
    '$onboardingPath/onboardingEnDark4.jpg',
  ];

  static final List<String> warningSymbols = [
    '$warningPath/air_bad_symbol_in_red.png',
    '$warningPath/airbag_warning_symbol_in_red.png',
    '$warningPath/srs_symbol_in_red.png',
    '$warningPath/airbag_off_symbol_in_red.png',
    '$warningPath/at_oil_temp_symbol_in_red.png',
    '$warningPath/at_p_symbol_in_red.png',
    '$warningPath/battery_symbol_in_red.png',
    '$warningPath/bonnet_open.png',
    '$warningPath/boot_trunk_open.png',
    '$warningPath/brake_fluid_warning_symbol_in_red.png',
    '$warningPath/brake_pad_warning_symbol_in_red.png',
    '$warningPath/brake_warning_symbol_in_red.png',
    '$warningPath/brake_warning_symbol_in_red_2.png',
    '$warningPath/brake_warning_symbol_in_red_1.png',
    '$warningPath/hand_brake__parking_break_symbol_in_red.png',
    '$warningPath/car_key_symbol_in_red.png',
    '$warningPath/car_lock_symbol_in_red.png',
    '$warningPath/door__doors_open_warning_symbol_in_red.png',
    '$warningPath/Engine_Temperature_Warning.png',
    '$warningPath/hazard_warning_light_symbol_in_red.png',
    '$warningPath/lock_symbol_in_red.png',
    '$warningPath/low_engine_oil_wanring_light_in_red.png',
    '$warningPath/oil_pressure_warning_symbol_in_red.png',
    '$warningPath/power_steering_symbol_in_red.png',
    '$warningPath/seatbelt_symbol_in_red.png',
    '$warningPath/transmission_temperature_warning_symbol_in_red.png',
    '$warningPath/transmission_warning_symbol_in_red.png',
    '$warningPath/warning_symbol_in_red.png'
  ];

  static final List<String> advisorySymbols = [
    '$advisoryPath/abs_warning_light_in_orange.png',
    '$advisoryPath/brake_pad_warning_symbol_in_orange.png',
    '$advisoryPath/brake_warning_symbol_in_orange.png',
    '$advisoryPath/brake_warning_symbol_in_orange_1.png',
    '$advisoryPath/esp_warning_light_in_orange.png',
    '$advisoryPath/press_brake_pedal_symbol_in_orange.png',
    '$advisoryPath/rbs_warning_light_in_orange.png',
    '$advisoryPath/regenerative_brake_force_symbol_in_orange.png',
    '$advisoryPath/at_oil_temp_symbol_in_orange.png',
    '$advisoryPath/car_key_symbol_in_orange.png',
    '$advisoryPath/differential_lock_symbol_in_orange.png',
    '$advisoryPath/centre_differential_lock_symbol_in_orange.png',
    '$advisoryPath/rear_differential_lock_symbol_in_orange.png',
    '$advisoryPath/rear_differential_lock_symbol_in_orange_1.png',
    '$advisoryPath/charging_symbol_in_orange.png',
    '$advisoryPath/Cruise_Control.png',
    '$advisoryPath/dpf_warning_symbol_in_orange.png',
    '$advisoryPath/glow_plug_symbol_in_orange.png',
    '$advisoryPath/water_in_fuel_symbol_in_orange_1.png',
    '$advisoryPath/electric_charging_symbol_in_orange.png',
    '$advisoryPath/engine_check_symbol_in_orange.png',
    '$advisoryPath/jack__ramp_symbol_in_orange.png',
    '$advisoryPath/lane_assist_symbol_in_orange.png',
    '$advisoryPath/low_engine_oil_symbol_in_orange.png',
    '$advisoryPath/low_fuel_warning_light_in_orange.png',
    '$advisoryPath/low_screen_wash_fluid_symbol_in_orange.png',
    '$advisoryPath/oil_level_symbol_in_orange.png',
    '$advisoryPath/parking_sensor_symbol_in_orange.png',
    '$advisoryPath/pcs_symbol_in_orange.png',
    '$advisoryPath/power_limitation_indicator_symbol_in_orange.png',
    '$advisoryPath/ps_symbol_in_orange.png',
    '$advisoryPath/service_indicator_symbol_in_orange.png',
    '$advisoryPath/side_air_bag_symbol_in_orange.png',
    '$advisoryPath/startstop_symbol_in_orange.png',
    '$advisoryPath/tcs_off_symbol_in_orange.png',
    '$advisoryPath/tcs_symbol_in_orange_1.png',
    '$advisoryPath/towing_symbol_in_orange.png',
    '$advisoryPath/tpms_warning_symbol_in_orange.png',
    '$advisoryPath/tpms_warning_symbol_in_orange_1.png',
    '$advisoryPath/tranmission_warning_symbol_in_orange.png',
    '$advisoryPath/4wd_symbol_in_orange.png',
    '$advisoryPath/4x2_symbol_in_orange.png',
    '$advisoryPath/4x4_auto_symbol_in_orange.png',
    '$advisoryPath/4x4_high_symbol_in_orange.png',
    '$advisoryPath/4x4_low_symbol_in_orange.png',
    '$advisoryPath/warning_symbol_in_orange.png',
    '$advisoryPath/information_symbol_in_orange.png',
  ];

  static final List<String> infoSymbols = [
    '$infoPath/fresh_air_ventilation_symbol_in_white.png',
    '$infoPath/air_flow_recirculation_symbol_in_white.png',
    '$infoPath/air_flow_lower_car_symbol_in_white.png',
    '$infoPath/air_flow_upper_and_lower_car_symbol_in_white.png',
    '$infoPath/air_flow_upper_car_symbol_in_white.png',
    '$infoPath/fan_symbol_in_white.png',
    '$infoPath/automatic_park_brake_symbol_in_green.png',
    '$infoPath/car_charging_symbol_in_green.png',
    '$infoPath/car_key_symbol_in_green.png',
    '$infoPath/car_key_symbol_in_green_1.png',
    '$infoPath/coolant_symbol_in_blue.png',
    '$infoPath/dipped_beam_symbol_in_white.png',
    '$infoPath/main_beam_symbol_in_white.png',
    '$infoPath/full_beam_symbol_in_blue.png',
    '$infoPath/full_beam_symbol_in_green.png',
    '$infoPath/self_levelling_headlight_symbol_in_green.png',
    '$infoPath/directional_headlight_symbol_in_green.png',
    '$infoPath/fog_light_symbol_in_white.png',
    '$infoPath/fog_light_symbol_in_green.png',
    '$infoPath/side_lights_symbol_in_green.png',
    '$infoPath/side_lights_symbol_in_white.png',
    '$infoPath/indicator_symbol_in_green.png',
    '$infoPath/indicator_symbol_in_white.png',
    '$infoPath/interior_light_symbol_in_green.png',
    '$infoPath/interior_light_warning_in_green.png',
    '$infoPath/eco_mode_symbol_in_green.png',
    '$infoPath/eco_mode_symbol_in_green_1.png',
    '$infoPath/engine_start_stop_symbol_in_green.png',
    '$infoPath/ev_mode_symbol_in_green.png',
    '$infoPath/off_symbol_in_white.png',
    '$infoPath/on_symbol_in_white.png',
    '$infoPath/parking_sensor_symbol_in_green.png',
    '$infoPath/windshield_defrost_symbol_in_white.png',
    '$infoPath/rear_window_defrost_symbol_in_white.png',
    '$infoPath/screenwash_symbol_in_white.png',
    '$infoPath/window_wiper_symbol_in_white_1.png',
    '$infoPath/shift_light_symbol_in_green.png',
  ];
}
