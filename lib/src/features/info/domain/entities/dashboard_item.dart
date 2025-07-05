import 'package:equatable/equatable.dart';

class DashboardItem extends Equatable {
  final int category;
  final String image;
  final String title;
  final String description;
  final String advice;
  final int severity;

  const DashboardItem({
    required this.category,
    required this.image,
    required this.title,
    required this.description,
    required this.advice,
    required this.severity,
  });

  @override
  List<Object?> get props =>
      [category, image, title, description, advice, severity];

  DashboardItem copyWith({
    int? category,
    String? image,
    String? title,
    String? description,
    String? advice,
    int? severity,
  }) {
    return DashboardItem(
      category: category ?? this.category,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      advice: advice ?? this.advice,
      severity: severity ?? this.severity,
    );
  }

  @override
  String toString() {
    return 'DashboardItem(category: $category, title: $title, severity: $severity)';
  }
}
