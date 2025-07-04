# Flutter Project Directory Structure

```
lib/
├── src/
│   ├── config/
│   │   ├── locale/
│   │   │   ├── app_localizations.dart
│   │   │   ├── app_localizations_delegate.dart
│   │   │   └── app_localizations_setup.dart
│   │   ├── routes/
│   │   │   └── app_routes.dart
│   │   └── themes/
│   │       ├── system/
│   │       │   └── system_overlay_style.dart
│   │       ├── widgets/
│   │       │   ├── app_bar_themes.dart
│   │       │   ├── button_themes.dart
│   │       │   ├── card_themes.dart
│   │       │   ├── dialog_themes.dart
│   │       │   ├── icon_themes.dart
│   │       │   ├── scrollbar_theme.dart
│   │       │   ├── text_field_theme.dart
│   │       │   └── text_themes.dart
│   │       └── app_theme.dart
│   ├── core/
│   │   ├── database/
│   │   │   └── database_helper.dart
│   │   ├── errors/
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── extensions/
│   │   │   ├── media_query_values.dart
│   │   │   └── string_helper.dart
│   │   ├── services/
│   │   │   ├── animations/
│   │   │   │   └── animation_helper.dart
│   │   │   ├── app_tutorial/
│   │   │   │   └── app_tour_service.dart
│   │   │   ├── dialogs/
│   │   │   │   └── dialog_helper.dart
│   │   │   ├── file_creator/
│   │   │   │   └── file_creator.dart
│   │   │   ├── form_validation/
│   │   │   │   ├── form_validation.dart
│   │   │   │   └── validation_item.dart
│   │   │   ├── notifications/
│   │   │   │   └── notifications_helper.dart
│   │   │   └── text_input_formatters/
│   │   │       ├── thousand_separator_input_formatter.dart
│   │   │       └── title_case_input_formatter.dart
│   │   ├── usecases/
│   │   │   └── usecase.dart
│   │   ├── utils/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_dimens.dart
│   │   │   ├── app_ids.dart
│   │   │   ├── app_input_borders.dart
│   │   │   ├── app_keys.dart
│   │   │   ├── app_lists.dart
│   │   │   ├── app_nums.dart
│   │   │   ├── app_strings.dart
│   │   │   ├── app_texts.dart
│   │   │   └── asset_manager.dart
│   │   └── widgets/
│   │       ├── ads/
│   │       │   └── banner_ad_widget.dart
│   │       ├── buttons/
│   │       │   ├── animated_button.dart
│   │       │   ├── animated_button_with_icon.dart
│   │       │   └── animated_icon_button.dart
│   │       ├── dialogs/
│   │       │   └── warning_dialog.dart
│   │       ├── indicators/
│   │       │   └── custom_progress_indictor.dart
│   │       ├── logo/
│   │       │   └── logo_widget.dart
│   │       ├── text_fields/
│   │       │   ├── consumable_name_text_field.dart
│   │       │   └── custom_text_form_field.dart
│   │       └── texts/
│   │           └── title_text.dart
│   └── features/
│       ├── car_info/
│       │   ├── domain/
│       │   │   └── entities/
│       │   │       ├── car.dart
│       │   │       └── car.g.dart
│       │   └── presentation/
│       │       ├── cubit/
│       │       │   ├── car_cubit.dart
│       │       │   └── car_state.dart
│       │       ├── pages/
│       │       │   └── car_info_screen.dart
│       │       └── widgets/
│       │           ├── car_type_text_form_field.dart
│       │           ├── continue_button.dart
│       │           ├── current_kilometer_text_form_field.dart
│       │           ├── model_year_text_form_field.dart
│       │           └── switch_lang_button_widget.dart
│       ├── consumables/
│       │   ├── domain/
│       │   │   └── entities/
│       │   │       ├── consumable.dart
│       │   │       └── consumable.g.dart
│       │   └── presentation/
│       │       ├── cubit/
│       │       │   ├── consumable_cubit.dart
│       │       │   └── consumable_state.dart
│       │       ├── pages/
│       │       │   ├── add_consumable.dart
│       │       │   └── consumables_screen.dart
│       │       └── widgets/
│       │           ├── add_consumable_screen_widgets/
│       │           │   ├── bottom_buttons_widget.dart
│       │           │   ├── change_interval_text_form_field.dart
│       │           │   ├── consumable_data_card_widget.dart
│       │           │   └── last_changed_text_form_field.dart
│       │           ├── consumable_item_widget/
│       │           │   ├── change_interval_text_form_field.dart
│       │           │   ├── consumable_item_widget.dart
│       │           │   ├── last_changed_text_form_field.dart
│       │           │   └── remaining_kilometer_text_form_field.dart
│       │           ├── app_bar_current_kilometer_text_field.dart
│       │           ├── app_bar_icon_buttons_row.dart
│       │           ├── bottom_buttons.dart
│       │           ├── consumables_list_widget.dart
│       │           └── empty_list_widget.dart
│       ├── info/
│       │   ├── domain/
│       │   │   └── entities/
│       │   │       └── dashboard_item.dart
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── dashboard_screen.dart
│       │       └── widgets/
│       │           └── dashboard_symbols_card.dart
│       ├── intro/
│       │   ├── data/
│       │   │   ├── data_sources/
│       │   │   │   └── lang_local_data_source.dart
│       │   │   └── repositories/
│       │   │       └── lang_repository_impl.dart
│       │   ├── domain/
│       │   │   ├── entities/
│       │   │   │   └── onboarding_page.dart
│       │   │   ├── repositories/
│       │   │   │   └── lang_repository.dart
│       │   │   └── usecases/
│       │   │       ├── change_lang.dart
│       │   │       └── get_saved_lang.dart
│       │   └── presentation/
│       │       ├── cubit/
│       │       │   ├── locale_cubit.dart
│       │       │   └── locale_state.dart
│       │       ├── pages/
│       │       │   ├── language_selection_screen.dart
│       │       │   ├── onboarding_screen.dart
│       │       │   └── splash_screen.dart
│       │       └── widgets/
│       │           ├── language_selection_screen_widgets/
│       │           │   ├── choose_language_text_widget.dart
│       │           │   ├── continue_button_widget.dart
│       │           │   └── language_selection_widget.dart
│       │           └── onboarding_screen/
│       │               ├── hint_text.dart
│       │               ├── pager_widget.dart
│       │               └── title_text.dart
│       └── my_cars/
│           ├── domain/
│           │   └── entities/
│           └── presentation/
│               ├── manager/
│               ├── pages/
│               │   └── my_cars_screen.dart
│               └── widgets/
│                   ├── bottom_buttons_widget.dart
│                   ├── car_data.dart
│                   ├── car_details.dart
│                   ├── icons_row.dart
│                   ├── logo_and_my_cars_list_widgets.dart
│                   ├── my_cars_list.dart
│                   ├── my_cars_list_item.dart
│                   ├── my_cars_screen_widget.dart
│                   ├── switch_lang_button_widget.dart
│                   └── car_note.dart
├── injection_container.dart
└── main.dart
```

## Project Structure Overview

This Flutter project follows **Clean Architecture** principles with clear separation of concerns:

### Key Architecture Layers:

- **Core**: Shared utilities, services, and base classes
- **Features**: Domain-specific modules (car_info, consumables, info, intro, my_cars)
- **Config**: App configuration (themes, routes, localization)

### Notable Patterns:

- **Feature-based organization** with domain/data/presentation layers
- **Cubit pattern** for state management
- **Dependency injection** setup
- **Comprehensive theming** system
- **Localization** support
- **Reusable widgets** library

Each feature follows the same structure: domain entities, presentation logic (cubits), UI pages, and
specialized widgets.