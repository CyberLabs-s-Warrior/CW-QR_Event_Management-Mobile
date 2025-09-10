import 'package:flutter/widgets.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/error/clean_error_message_cleaner.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/usecases/get_event_by_id_usecase.dart';

class EventDashboardProvider extends ChangeNotifier {
  final GetEventByIdUsecase getEventByIdUsecase;
  // final ScanAttendanceUsecase scanAttendanceUsecase;

  EventDashboardProvider({
    required this.getEventByIdUsecase,
    // required this.scanAttendanceUsecase
  });

  //? init
  String? _errorMessage;

  // dashboard
  EventEntity? _event;
  

  ResponseStatus _eventStatus = ResponseStatus.initial;

  //? getters
  String get cleanErrorMessage => _errorMessage.cleanErrorMessage;
  EventEntity? get event => _event;
  ResponseStatus get eventStatus => _eventStatus;

  void _setEventStatus(ResponseStatus status) {
    _eventStatus = status;
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
}
