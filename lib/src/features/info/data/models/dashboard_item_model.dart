import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:hive/hive.dart';

part 'dashboard_item_model.g.dart';

@HiveType(typeId: 3)
class DashboardItemModel extends HiveObject {
  @HiveField(0)
  final int category;
  
  @HiveField(1)
  final String image;
  
  @HiveField(2)
  final String title;
  
  @HiveField(3)
  final String description;
  
  @HiveField(4)
  final String advice;
  
  @HiveField(5)
  final int severity;

  DashboardItemModel({
    required this.category,
    required this.image,
    required this.title,
    required this.description,
    required this.advice,
    required this.severity,
  });

  // Convert from domain entity to data model
  factory DashboardItemModel.fromEntity(DashboardItem dashboardItem) {
    return DashboardItemModel(
      category: dashboardItem.category,
      image: dashboardItem.image,
      title: dashboardItem.title,
      description: dashboardItem.description,
      advice: dashboardItem.advice,
      severity: dashboardItem.severity,
    );
  }

  // Convert from data model to domain entity
  DashboardItem toEntity() {
    return DashboardItem(
      category: category,
      image: image,
      title: title,
      description: description,
      advice: advice,
      severity: severity,
    );
  }

  // For JSON serialization (if needed for API calls)
  factory DashboardItemModel.fromJson(Map<String, dynamic> json) {
    return DashboardItemModel(
      category: json['category'] ?? 0,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      advice: json['advice'] ?? '',
      severity: json['severity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'image': image,
      'title': title,
      'description': description,
      'advice': advice,
      'severity': severity,
    };
  }

  @override
  String toString() {
    return 'DashboardItemModel(category: $category, image: $image, title: $title, severity: $severity)';
  }
}
