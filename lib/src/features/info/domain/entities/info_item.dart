import 'package:equatable/equatable.dart';

class InfoItem extends Equatable {
  final int category;
  final String image;
  final String title;
  final String? description;
  final String? advice;
  final int severity;

  const InfoItem({
    required this.category,
    required this.image,
    required this.title,
    required this.description,
    required this.advice,
    required this.severity,
  });

  @override
  List<Object?> get props => [category, image, title, description, advice, severity];
}
