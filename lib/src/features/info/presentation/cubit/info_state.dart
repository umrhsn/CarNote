part of 'info_cubit.dart';

abstract class InfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final List<DashboardItem> items;

  InfoLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class InfoError extends InfoState {
  final String message;

  InfoError(this.message);

  @override
  List<Object?> get props => [message];
}

class InfoItemSelected extends InfoState {
  final int index;
  final DashboardItem item;

  InfoItemSelected(this.index, this.item);

  @override
  List<Object?> get props => [index, item];
}

class InfoSelectionCleared extends InfoState {}

class InfoViewModeChanged extends InfoState {
  final bool isListView;

  InfoViewModeChanged(this.isListView);

  @override
  List<Object?> get props => [isListView];
}

class InfoSorted extends InfoState {
  final String sortBy;
  final List<DashboardItem> items;

  InfoSorted(this.sortBy, this.items);

  @override
  List<Object?> get props => [sortBy, items];
}

class InfoFiltered extends InfoState {
  final int category;
  final List<DashboardItem> items;

  InfoFiltered(this.category, this.items);

  @override
  List<Object?> get props => [category, items];
}
