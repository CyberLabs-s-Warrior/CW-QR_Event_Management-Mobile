import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeSummaryEntity.dart';
import 'package:qr_event_management/features/Home/domain/usecases/home_summary_usecase.dart';

enum HomeStatus { initial, loading, success, error }

class HomeProvider extends ChangeNotifier {
  final HomeSummaryUsecase homeSummaryUsecase;

  HomeProvider({required this.homeSummaryUsecase});

  HomeStatus _homeSummaryStatus = HomeStatus.initial;

  HomeSummaryEntity? _homeSummary;
  String? _errorMessage;
  // here
  Timer? _autoTimer;
  bool _disposed = false;

  // getter
  HomeStatus get homeSummaryStatus => _homeSummaryStatus;

  // getter data location
  HomeSummaryEntity? get homeSummary => _homeSummary;


  String get pastCountText =>
      _homeSummary?.pastCount.toString() ?? '0';
  String get upcomingEventText =>
      _homeSummary?.upcomingEvent.toString() ?? 'No Upcoming Event';

  String? get errorMessage => _errorMessage;


  String get cleanErrorMessage {
    if (_errorMessage == null) return 'An error occured';

    String cleanMessage = _errorMessage!;

    if (cleanMessage.startsWith('EmptyException: ')) {
      cleanMessage = cleanMessage.replaceFirst('EmptyException: ', '');
    }
    if (cleanMessage.startsWith('GeneralException: ')) {
      cleanMessage = cleanMessage.replaceFirst('GeneralException: ', '');
    }
    if (cleanMessage.startsWith('ServerException: ')) {
      cleanMessage = cleanMessage.replaceFirst('ServerException: ', '');
    }

    return cleanMessage;
  }

  // setter

  void _setHomeSummaryStatus(HomeStatus status) {
    _homeSummaryStatus = status;
    notifyListeners();
  }

  Future<void> getHomeSummary({
    required String token,
    required int userId,
  }) async {
    // here
    // Hindari overlap agar request sebelumnya selesai dulu
    if (_homeSummaryStatus == HomeStatus.loading) return;
    _setHomeSummaryStatus(HomeStatus.loading);

    final result = await homeSummaryUsecase.execute(token, userId);
    print('from provider: $result');

    result.fold(
      (failure) {
        // here
        print(
          'error message: ${failure.message}, result: ${result}, all failure: $failure',
        );
        _errorMessage = failure.message;
        _setHomeSummaryStatus(HomeStatus.error);
      },
      (summary) {
        _homeSummary = summary;
        _setHomeSummaryStatus(HomeStatus.success);
      },
    );
  }

  void resetState() {
    _homeSummary = null;
    _errorMessage = null;
    _homeSummaryStatus = HomeStatus.initial;
    notifyListeners();
  }

  // here
  // Mulai auto refresh setiap interval (default 5 detik)
  void startAutoRefresh({Duration interval = const Duration(seconds: 5), required String token, required int userId}) {
    _autoTimer?.cancel();
    // Fetch pertama segera
    getHomeSummary(token: token, userId: userId);
    _autoTimer = Timer.periodic(interval, (_) {
      if (_disposed) return;
      getHomeSummary(token: token, userId: userId);
    });
  }

  void stopAutoRefresh() {
    _autoTimer?.cancel();
    _autoTimer = null;
  }

  @override
  void dispose() {
    _disposed = true;
    _autoTimer?.cancel();
    super.dispose();
  }
}
