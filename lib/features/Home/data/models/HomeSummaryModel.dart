import '../../domain/entities/HomeSummaryEntity.dart';

class HomeSummaryModel extends HomeSummaryEntity {
  const HomeSummaryModel({
    required super.pastCount,
    required super.upcomingEvent,
    required super.currentMonthCount,
  });

  factory HomeSummaryModel.fromJson(Map<String, dynamic> data) {
    return HomeSummaryModel(
      pastCount: data['past_count'],
      upcomingEvent: data['upcoming_event'],
      currentMonthCount: data['current_month_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'past_count': pastCount, 'upcoming_event': upcomingEvent,  'current_month_count': currentMonthCount};
  }
}
