import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String location;
  final String eventCategory;
  final String createdBy;
  final String status;
  final String startDate;
  final String endDate;
  final String banner;
  final String createdAt;

  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.eventCategory,
    required this.createdBy,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.banner,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    location,
    eventCategory,
    createdBy,
    status,
    startDate,
    endDate,
    banner,
    createdAt,
  ];
}
