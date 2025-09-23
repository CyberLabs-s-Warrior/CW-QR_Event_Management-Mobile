import 'package:intl/intl.dart';

import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    required super.eventCategory,
    required super.createdBy,
    required super.status,
    required super.startDate,
    required super.endDate,
    required super.banner,
    required super.createdAt,
    required super.attendancePercentage,
    required super.attendeeCount,
    required super.presentOrLateCount,
    required super.absentCount,
  });

  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      location: data['location'],
      eventCategory: data['event_category']['name'],
      createdBy: data['created_by']['name'],
      status: data['status'],
      startDate: DateFormat(
        'd MMMM yyyy HH:mm',
      ).format(DateTime.parse(data['start_date'])),
      endDate: DateFormat(
        'd MMMM yyyy HH:mm',
      ).format(DateTime.parse(data['end_date'])),
      banner: data['banner'],
      createdAt: data['created_at'],
      attendancePercentage: data['attendance_percentage'],
      attendeeCount: data['attendee_count'],
      presentOrLateCount: data['present_or_late_count'],
      absentCount: data['absent_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'event_category': {'name': eventCategory},
      'created_by': {'name': createdBy},
      'status': status,
      'start_date': startDate,
      'end_date': endDate,
      'banner': banner,
      'created_at': createdAt,
      'attendance_percentage': attendancePercentage,
      'present_or_late_count': presentOrLateCount,
      'absent_count': absentCount,
    };
  }
}
