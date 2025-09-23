import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/error/clean_error_message_cleaner.dart';
import '../../domain/entities/attendance_data_entity.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/list_attendees_entity.dart';
import '../../domain/usecases/get_event_attendees_usecase.dart';
import '../../domain/usecases/get_event_by_id_usecase.dart';
import '../../domain/usecases/scan_attendance_usecase.dart';
import '../../domain/usecases/scan_identity_check_usecase.dart';
import '../../domain/usecases/update_attendees_status_usecase.dart';

class EventDashboardProvider extends ChangeNotifier {
  final GetEventByIdUsecase getEventByIdUsecase;
  final ScanAttendanceUsecase scanAttendanceUsecase;
  final ScanIdentityCheckUsecase scanIdentityCheckUsecase;
  final GetEventAttendeesUsecase getEventAttendeesUsecase;
  final UpdateAttendeesStatusUsecase updateAttendeesStatusUsecase;

  EventDashboardProvider({
    required this.getEventByIdUsecase,
    required this.scanAttendanceUsecase,
    required this.scanIdentityCheckUsecase,
    required this.getEventAttendeesUsecase,
    required this.updateAttendeesStatusUsecase,
  });

  //? init
  String? _errorMessage;

  // dashboard
  EventEntity? _event;

  // attendance
  AttendanceDataEntity? _attendanceData;
  ListAttendeesEntity? _listAttendees;

  ResponseStatus _eventStatus = ResponseStatus.initial;
  ResponseStatus _attendanceStatus = ResponseStatus.initial;
  ResponseStatus _listAttendeesStatus = ResponseStatus.initial;
  ResponseStatus _updateAttendeesStatus = ResponseStatus.initial;

  //? getters
  String get cleanErrorMessage => _errorMessage.cleanErrorMessage;
  EventEntity? get event => _event;
  AttendanceDataEntity? get attendanceData => _attendanceData;
  ListAttendeesEntity? get listAttendee => _listAttendees;
  ResponseStatus get eventStatus => _eventStatus;
  ResponseStatus get attendanceStatus => _attendanceStatus;
  ResponseStatus get listAttendeeStatus => _listAttendeesStatus;
  ResponseStatus get updateAttendeesStatus => _updateAttendeesStatus;

  void _setEventStatus(ResponseStatus status) {
    _eventStatus = status;
    notifyListeners();
  }

  void _setAttendanceStatus(ResponseStatus status) {
    _attendanceStatus = status;
    notifyListeners();
  }

  void _setListAttendeesStatus(ResponseStatus status) {
    _listAttendeesStatus = status;
    notifyListeners();
  }

  void _setUpdateAttendeesStatus(ResponseStatus status) {
    _updateAttendeesStatus = status;
    notifyListeners();
  }

  Future<void> getEventById(token, eventId) async {
    _setEventStatus(ResponseStatus.loading);

    final result = await getEventByIdUsecase.execute(token, eventId);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        print(_errorMessage);
        _setEventStatus(ResponseStatus.error);
      },
      (event) {
        _event = event;
        print(event);
        _setEventStatus(ResponseStatus.success);
      },
    );
  }

  // Future<void> scanAttendance(token, eventId, code) async {
  //   _setAttendanceStatus(ResponseStatus.loading);

  //   final result = await scanAttendanceUsecase.execute(token, eventId, code);

  //   result.fold(
  //     (failure) {
  //       _errorMessage = failure.message;
  //       _setAttendanceStatus(ResponseStatus.error);
  //     },
  //     (attendance) {
  //       _attendanceData = attendance;
  //       _setAttendanceStatus(ResponseStatus.success);
  //     },
  //   );
  // }

  Future<void> scanAttendance(String token, int eventId, String? qrData) async {
    _setAttendanceStatus(ResponseStatus.loading);

    try {
      if (qrData == null || qrData.isEmpty) {
        _errorMessage = "Invalid QR code";
        _setAttendanceStatus(ResponseStatus.error);
        return;
      }

      // Try to parse as JSON first
      try {
        final jsonData = jsonDecode(qrData);
        // If successful, extract attendeeId from JSON
        if (jsonData.containsKey("qrcode_data")) {
          final attendeeId = jsonData["qrcode_data"];
          await processAttendance(token, eventId, attendeeId);
          return;
        } else {
          _errorMessage = "QR code is missing required data";
          _setAttendanceStatus(ResponseStatus.error);
          return;
        }
      } catch (e) {
        // Not JSON, assume the entire string is the attendee ID
        print("QR code is not JSON, using as plain ID: $qrData");
        await processAttendance(token, eventId, qrData);
        return;
      }
    } catch (e) {
      _errorMessage = "Failed to process QR code: $e";
      _setAttendanceStatus(ResponseStatus.error);
    }
  }

  // Helper method to process the attendance API call
  Future<void> processAttendance(
    String token,
    int eventId,
    String attendeeId,
  ) async {
    final result = await scanAttendanceUsecase.execute(
      token,
      eventId,
      attendeeId,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setAttendanceStatus(ResponseStatus.error);
      },
      (attendanceData) {
        _attendanceData = attendanceData;
        _setAttendanceStatus(ResponseStatus.success);
      },
    );
  }

  Future<void> scanIdentityCheck(token, eventId, code) async {
    _setAttendanceStatus(ResponseStatus.loading);

    final result = await scanIdentityCheckUsecase.execute(token, eventId, code);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setAttendanceStatus(ResponseStatus.error);
      },
      (attendance) {
        _attendanceData = attendance;
        _setAttendanceStatus(ResponseStatus.success);
      },
    );
  }

  Future<void> getEventAttendees(token, eventId) async {
    _setListAttendeesStatus(ResponseStatus.loading);

    final result = await getEventAttendeesUsecase.execute(token, eventId);

    result.fold(
      (failure) {
        _errorMessage = failure.message;

        print('error loading attendees at provider: $_errorMessage');

        _setListAttendeesStatus(ResponseStatus.error);
      },
      (attendees) {
        _listAttendees = attendees;
        _setListAttendeesStatus(ResponseStatus.success);
      },
    );
  }

  Future<void> updateAttendees(
     token,
     eventId,
    List<Map<String, dynamic>> attendeesData,
  ) async {
    _setUpdateAttendeesStatus(ResponseStatus.loading);

      final result = await updateAttendeesStatusUsecase.execute(
        token,
        eventId,
        attendeesData,
      );

      result.fold(
        (failure) {
          _errorMessage = failure.message;
          print('Update attendees error: $_errorMessage');
          _setUpdateAttendeesStatus(ResponseStatus.error);
        },
        (success) {
          print('Update attendees success: $success');

          // Refresh attendees list
          getEventAttendees(token, eventId);
          _setUpdateAttendeesStatus(ResponseStatus.success);
        },
      );
    
  }

  void resetAttendanceStatus() {
    _attendanceStatus = ResponseStatus.initial;
    notifyListeners();
  }

  void resetAttendanceState() {
    _attendanceData = null;
    notifyListeners();
  }
}
