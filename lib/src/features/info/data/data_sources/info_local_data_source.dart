import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:flutter/material.dart';

abstract class InfoLocalDataSource {
  List<DashboardItem> getDashboardItems(BuildContext context);
  List<DashboardItem> getDashboardItemsByCategory(BuildContext context, int category);
  List<DashboardItem> searchDashboardItems(BuildContext context, String query);
  List<DashboardItem> sortDashboardItems(List<DashboardItem> items, String sortBy);
}

class InfoLocalDataSourceImpl implements InfoLocalDataSource {
  @override
  List<DashboardItem> getDashboardItems(BuildContext context) {
    // Use the existing AppLists.dashboardItems method
    final items = AppLists.dashboardItems(context);
    return items;
  }

  @override
  List<DashboardItem> getDashboardItemsByCategory(BuildContext context, int category) {
    final allItems = getDashboardItems(context);
    return allItems.where((item) => item.category == category).toList();
  }

  @override
  List<DashboardItem> searchDashboardItems(BuildContext context, String query) {
    final allItems = getDashboardItems(context);
    if (query.isEmpty) return allItems;
    
    final lowerQuery = query.toLowerCase();
    return allItems.where((item) =>
      item.title.toLowerCase().contains(lowerQuery) ||
      item.description.toLowerCase().contains(lowerQuery) ||
      item.advice.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  @override
  List<DashboardItem> sortDashboardItems(List<DashboardItem> items, String sortBy) {
    final sortedItems = List<DashboardItem>.from(items);
    
    switch (sortBy.toLowerCase()) {
      case 'alphabetical':
      case 'title':
        sortedItems.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'category':
        sortedItems.sort((a, b) {
          final categoryComparison = a.category.compareTo(b.category);
          return categoryComparison != 0 ? categoryComparison : a.title.compareTo(b.title);
        });
        break;
      case 'severity':
        sortedItems.sort((a, b) {
          final severityComparison = b.severity.compareTo(a.severity); // Descending
          return severityComparison != 0 ? severityComparison : a.title.compareTo(b.title);
        });
        break;
      default:
        // Default to alphabetical
        sortedItems.sort((a, b) => a.title.compareTo(b.title));
    }
    
    return sortedItems;
  }
}
