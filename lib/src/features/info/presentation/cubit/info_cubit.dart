import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/info/domain/use_cases/get_dashboard_items_use_case.dart';
import 'package:car_note/src/features/info/domain/use_cases/search_dashboard_items_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  final GetDashboardItemsUseCase getDashboardItemsUseCase;
  final SearchDashboardItemsUseCase searchDashboardItemsUseCase;

  InfoCubit({
    required this.getDashboardItemsUseCase,
    required this.searchDashboardItemsUseCase,
  }) : super(InfoInitial());

  static InfoCubit get(BuildContext context) => BlocProvider.of<InfoCubit>(context);

  List<DashboardItem> _allItems = [];
  List<DashboardItem> _filteredItems = [];
  int? _selectedIndex;
  bool _switchToListView = false;
  String _currentSortBy = 'alphabetical';

  // Getters
  List<DashboardItem> get allItems => _allItems;
  List<DashboardItem> get filteredItems => _filteredItems;
  int? get selectedIndex => _selectedIndex;
  bool get switchToListView => _switchToListView;
  String get currentSortBy => _currentSortBy;

  Future<void> loadDashboardItems() async {
    emit(InfoLoading());

    final result = await getDashboardItemsUseCase(NoParams());
    result.fold(
      (failure) => emit(InfoError(failure.message)),
      (items) {
        _allItems = items;
        _filteredItems = List.from(items);
        emit(InfoLoaded(items));
      },
    );
  }

  Future<void> searchItems(String query) async {
    if (_allItems.isEmpty) return;

    emit(InfoLoading());

    final result = await searchDashboardItemsUseCase(query);
    result.fold(
      (failure) => emit(InfoError(failure.message)),
      (items) {
        _filteredItems = items;
        _selectedIndex = null; // Reset selection when searching
        emit(InfoLoaded(items));
      },
    );
  }

  void selectItem(int index) {
    _selectedIndex = index;
    emit(InfoItemSelected(index, _filteredItems[index]));
  }

  void clearSelection() {
    _selectedIndex = null;
    emit(InfoSelectionCleared());
  }

  void toggleViewMode() {
    _switchToListView = !_switchToListView;
    _selectedIndex = null;
    emit(InfoViewModeChanged(_switchToListView));
  }

  void sortItems(String sortBy) {
    _currentSortBy = sortBy;
    // Note: Sorting logic would be implemented in repository
    // For now, just emit the current state
    emit(InfoSorted(sortBy, _filteredItems));
  }

  void filterByCategory(int category) {
    final filtered = _allItems.where((item) => item.category == category).toList();
    _filteredItems = filtered;
    _selectedIndex = null;
    emit(InfoFiltered(category, filtered));
  }

  void resetFilter() {
    _filteredItems = List.from(_allItems);
    _selectedIndex = null;
    emit(InfoLoaded(_filteredItems));
  }
}
