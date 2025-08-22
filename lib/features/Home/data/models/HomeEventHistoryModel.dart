import 'package:qr_event_management/features/Home/domain/entities/HomeEventHistoryEntity.dart';

class HomeEventHistoryModel extends HomeEventHistoryEntity {
  const HomeEventHistoryModel({
    required super.id,
    required super.title,
    required super.category,
    required super.endDate,
    required super.banner,
  });
}
