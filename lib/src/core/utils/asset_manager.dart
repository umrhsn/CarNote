import 'package:flutter/material.dart';

const String _imgPath = 'assets/images';

const String _dashboardLightsPath = '$_imgPath/dashboard_lights';
const String _warningPath = '$_dashboardLightsPath/warning';
const String _advisoryPath = '$_dashboardLightsPath/advisory';
const String _infoPath = '$_dashboardLightsPath/info';

const String _onboardingPath = '$_imgPath/onboarding';

const String _boycottPath = '$_imgPath/boycott';
const String _boycottLogosPath = '$_boycottPath/logos';
const String _boycottProofsPath = '$_boycottPath/proofs';

class AssetManager {
  static const String icon = '$_imgPath/icon.png';

  static Image splashImage() => Image.asset(icon, height: 150);

  static const String nothingHere = '$_imgPath/nothing_here.png';

  static const String ar = '$_imgPath/ar.png';
  static const String en = '$_imgPath/en.png';

  static final List<String> onboarding = [
    '$_onboardingPath/onboardingArLight1.jpg', // 0 (index)
    '$_onboardingPath/onboardingArLight2.jpg',
    '$_onboardingPath/onboardingArLight3.jpg',
    '$_onboardingPath/onboardingArLight4.jpg',
    '$_onboardingPath/onboardingEnLight1.jpg', // 4 (index + 4)
    '$_onboardingPath/onboardingEnLight2.jpg',
    '$_onboardingPath/onboardingEnLight3.jpg',
    '$_onboardingPath/onboardingEnLight4.jpg',
    '$_onboardingPath/onboardingArDark1.jpg', // 8 (index + 8)
    '$_onboardingPath/onboardingArDark2.jpg',
    '$_onboardingPath/onboardingArDark3.jpg',
    '$_onboardingPath/onboardingArDark4.jpg',
    '$_onboardingPath/onboardingEnDark1.jpg', // 12 (index + 12)
    '$_onboardingPath/onboardingEnDark2.jpg',
    '$_onboardingPath/onboardingEnDark3.jpg',
    '$_onboardingPath/onboardingEnDark4.jpg',
  ];

  static final List<String> warningSymbols = [
    '$_warningPath/air_bad_symbol_in_red.png',
    '$_warningPath/airbag_warning_symbol_in_red.png',
    '$_warningPath/srs_symbol_in_red.png',
    '$_warningPath/airbag_off_symbol_in_red.png',
    '$_warningPath/at_oil_temp_symbol_in_red.png',
    '$_warningPath/at_p_symbol_in_red.png',
    '$_warningPath/battery_symbol_in_red.png',
    '$_warningPath/bonnet_open.png',
    '$_warningPath/boot_trunk_open.png',
    '$_warningPath/brake_fluid_warning_symbol_in_red.png',
    '$_warningPath/brake_pad_warning_symbol_in_red.png',
    '$_warningPath/brake_warning_symbol_in_red.png',
    '$_warningPath/brake_warning_symbol_in_red_2.png',
    '$_warningPath/brake_warning_symbol_in_red_1.png',
    '$_warningPath/hand_brake__parking_break_symbol_in_red.png',
    '$_warningPath/car_key_symbol_in_red.png',
    '$_warningPath/car_lock_symbol_in_red.png',
    '$_warningPath/door__doors_open_warning_symbol_in_red.png',
    '$_warningPath/Engine_Temperature_Warning.png',
    '$_warningPath/hazard_warning_light_symbol_in_red.png',
    '$_warningPath/lock_symbol_in_red.png',
    '$_warningPath/low_engine_oil_wanring_light_in_red.png',
    '$_warningPath/oil_pressure_warning_symbol_in_red.png',
    '$_warningPath/power_steering_symbol_in_red.png',
    '$_warningPath/seatbelt_symbol_in_red.png',
    '$_warningPath/transmission_temperature_warning_symbol_in_red.png',
    '$_warningPath/transmission_warning_symbol_in_red.png',
    '$_warningPath/warning_symbol_in_red.png'
  ];

  static final List<String> advisorySymbols = [
    '$_advisoryPath/abs_warning_light_in_orange.png',
    '$_advisoryPath/brake_pad_warning_symbol_in_orange.png',
    '$_advisoryPath/brake_warning_symbol_in_orange.png',
    '$_advisoryPath/brake_warning_symbol_in_orange_1.png',
    '$_advisoryPath/esp_warning_light_in_orange.png',
    '$_advisoryPath/press_brake_pedal_symbol_in_orange.png',
    '$_advisoryPath/rbs_warning_light_in_orange.png',
    '$_advisoryPath/regenerative_brake_force_symbol_in_orange.png',
    '$_advisoryPath/at_oil_temp_symbol_in_orange.png',
    '$_advisoryPath/car_key_symbol_in_orange.png',
    '$_advisoryPath/differential_lock_symbol_in_orange.png',
    '$_advisoryPath/centre_differential_lock_symbol_in_orange.png',
    '$_advisoryPath/rear_differential_lock_symbol_in_orange.png',
    '$_advisoryPath/rear_differential_lock_symbol_in_orange_1.png',
    '$_advisoryPath/charging_symbol_in_orange.png',
    '$_advisoryPath/Cruise_Control.png',
    '$_advisoryPath/dpf_warning_symbol_in_orange.png',
    '$_advisoryPath/glow_plug_symbol_in_orange.png',
    '$_advisoryPath/water_in_fuel_symbol_in_orange_1.png',
    '$_advisoryPath/electric_charging_symbol_in_orange.png',
    '$_advisoryPath/engine_check_symbol_in_orange.png',
    '$_advisoryPath/jack__ramp_symbol_in_orange.png',
    '$_advisoryPath/lane_assist_symbol_in_orange.png',
    '$_advisoryPath/low_engine_oil_symbol_in_orange.png',
    '$_advisoryPath/low_fuel_warning_light_in_orange.png',
    '$_advisoryPath/low_screen_wash_fluid_symbol_in_orange.png',
    '$_advisoryPath/oil_level_symbol_in_orange.png',
    '$_advisoryPath/parking_sensor_symbol_in_orange.png',
    '$_advisoryPath/pcs_symbol_in_orange.png',
    '$_advisoryPath/power_limitation_indicator_symbol_in_orange.png',
    '$_advisoryPath/ps_symbol_in_orange.png',
    '$_advisoryPath/service_indicator_symbol_in_orange.png',
    '$_advisoryPath/side_air_bag_symbol_in_orange.png',
    '$_advisoryPath/startstop_symbol_in_orange.png',
    '$_advisoryPath/tcs_off_symbol_in_orange.png',
    '$_advisoryPath/tcs_symbol_in_orange_1.png',
    '$_advisoryPath/towing_symbol_in_orange.png',
    '$_advisoryPath/tpms_warning_symbol_in_orange.png',
    '$_advisoryPath/tpms_warning_symbol_in_orange_1.png',
    '$_advisoryPath/tranmission_warning_symbol_in_orange.png',
    '$_advisoryPath/4wd_symbol_in_orange.png',
    '$_advisoryPath/4x2_symbol_in_orange.png',
    '$_advisoryPath/4x4_auto_symbol_in_orange.png',
    '$_advisoryPath/4x4_high_symbol_in_orange.png',
    '$_advisoryPath/4x4_low_symbol_in_orange.png',
    '$_advisoryPath/warning_symbol_in_orange.png',
    '$_advisoryPath/information_symbol_in_orange.png',
  ];

  static final List<String> infoSymbols = [
    '$_infoPath/fresh_air_ventilation_symbol_in_white.png',
    '$_infoPath/air_flow_recirculation_symbol_in_white.png',
    '$_infoPath/air_flow_lower_car_symbol_in_white.png',
    '$_infoPath/air_flow_upper_and_lower_car_symbol_in_white.png',
    '$_infoPath/air_flow_upper_car_symbol_in_white.png',
    '$_infoPath/fan_symbol_in_white.png',
    '$_infoPath/automatic_park_brake_symbol_in_green.png',
    '$_infoPath/car_charging_symbol_in_green.png',
    '$_infoPath/car_key_symbol_in_green.png',
    '$_infoPath/car_key_symbol_in_green_1.png',
    '$_infoPath/coolant_symbol_in_blue.png',
    '$_infoPath/dipped_beam_symbol_in_white.png',
    '$_infoPath/main_beam_symbol_in_white.png',
    '$_infoPath/full_beam_symbol_in_blue.png',
    '$_infoPath/full_beam_symbol_in_green.png',
    '$_infoPath/self_levelling_headlight_symbol_in_green.png',
    '$_infoPath/directional_headlight_symbol_in_green.png',
    '$_infoPath/fog_light_symbol_in_white.png',
    '$_infoPath/fog_light_symbol_in_green.png',
    '$_infoPath/side_lights_symbol_in_green.png',
    '$_infoPath/side_lights_symbol_in_white.png',
    '$_infoPath/indicator_symbol_in_green.png',
    '$_infoPath/indicator_symbol_in_white.png',
    '$_infoPath/interior_light_symbol_in_green.png',
    '$_infoPath/interior_light_warning_in_green.png',
    '$_infoPath/eco_mode_symbol_in_green.png',
    '$_infoPath/eco_mode_symbol_in_green_1.png',
    '$_infoPath/engine_start_stop_symbol_in_green.png',
    '$_infoPath/ev_mode_symbol_in_green.png',
    '$_infoPath/off_symbol_in_white.png',
    '$_infoPath/on_symbol_in_white.png',
    '$_infoPath/parking_sensor_symbol_in_green.png',
    '$_infoPath/windshield_defrost_symbol_in_white.png',
    '$_infoPath/rear_window_defrost_symbol_in_white.png',
    '$_infoPath/screenwash_symbol_in_white.png',
    '$_infoPath/window_wiper_symbol_in_white_1.png',
    '$_infoPath/shift_light_symbol_in_green.png',
  ];

  static const String ps = '$_boycottPath/ps.png';
  static const String psWashout = '$_boycottPath/ps_washout.png';
}
