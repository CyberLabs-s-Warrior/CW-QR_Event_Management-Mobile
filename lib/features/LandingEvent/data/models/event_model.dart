import '../../domain/entities/event_entities.dart';

class EventModel extends EventEntities {
  const EventModel({
    required super.id,
    required super.title,
    required super.location,
    required super.startDate,
    required super.endDate,
    required super.banner,
    required super.createdBy,
  });

  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      title: data['title'],
      location: data['location'],
      startDate: data['start_date'],
      endDate: data['end_date'],
      banner: data['banner'],
      createdBy: data['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'start_date': startDate,
      'end_date': endDate,
      'banner': banner,
      'created_by': createdBy,
    };
  }

  static List<EventModel> fromJsonList(List data) {
    if (data.isEmpty) return [];

    return data.map((singleEvent) => EventModel.fromJson(singleEvent)).toList();
  }
}
