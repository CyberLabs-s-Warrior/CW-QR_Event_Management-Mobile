import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/error/clean_error_message_cleaner.dart';
import '../../domain/entities/HomeEventHistoryEntity.dart';
import '../../domain/entities/HomeSummaryEntity.dart';
import '../../domain/usecases/home_event_history_usecase.dart';
import '../../domain/usecases/home_summary_usecase.dart';

enum HomeStatus { initial, loading, success, error }

class HomeProvider extends ChangeNotifier {
  final HomeSummaryUsecase homeSummaryUsecase;
  final HomeEventHistoryUsecase homeEventHistoryUsecase;

  HomeProvider({
    required this.homeSummaryUsecase,
    required this.homeEventHistoryUsecase,
  });

  String? _errorMessage;

  //? HomeSummary
  HomeStatus _homeSummaryStatus = HomeStatus.initial;
  HomeSummaryEntity? _homeSummary;
  // here
  Timer? _autoTimer;
  bool _disposed = false;
  // getter
  HomeStatus get homeSummaryStatus => _homeSummaryStatus;
  // getter data location
  HomeSummaryEntity? get homeSummary => _homeSummary;

  String get cleanErrorMessage => _errorMessage.cleanErrorMessage;

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

  //? HomeEventHistory
  HomeStatus _homeEventHistoryStatus = HomeStatus.initial;
  List<HomeEventHistoryEntity>? _homeEventHistory;

  HomeStatus get homeEventHistoryStatus => _homeEventHistoryStatus;
  List<HomeEventHistoryEntity>? get homeEventHistory => _homeEventHistory;

  void _setHomeEventHistoryStatus(HomeStatus status) {
    _homeEventHistoryStatus = status;
    notifyListeners();
  }

  Future<void> getHomeEventHistory({
    required String token,
    required int userId,
  }) async {
    try {
      final result = await homeEventHistoryUsecase.execute(token, userId);

      result.fold(
        (failure) {
          print(
            'error message: ${failure.message}, result: ${result}, all failure: $failure',
          );

          _errorMessage = failure.message;
          _setHomeEventHistoryStatus(HomeStatus.error);
        },
        (eventHistory) {
          _homeEventHistory = eventHistory;
          _setHomeEventHistoryStatus(HomeStatus.success);
        },
      );
    } catch (e) {
      _setHomeSummaryStatus(HomeStatus.error);
      _errorMessage = e.toString();
      notifyListeners();

      print('Event history error: $e');
    }
  }

  Future<void> getHomeSummaryRefresh({
    required String token,
    required int userId,
  }) async {
    _setHomeSummaryStatus(HomeStatus.loading);

    final result = await homeSummaryUsecase.execute(token, userId);
    print('from provider: $result');

    result.fold(
      (failure) {
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

  Future<void> getHomeEventHistoryRefresh({
    required String token,
    required int userId,
  }) async {
    try {
      _setHomeSummaryStatus(HomeStatus.loading);

      final result = await homeEventHistoryUsecase.execute(token, userId);

      result.fold(
        (failure) {
          print(
            'error message: ${failure.message}, result: ${result}, all failure: $failure',
          );

          _errorMessage = failure.message;
          _setHomeEventHistoryStatus(HomeStatus.error);
        },
        (eventHistory) {
          _homeEventHistory = eventHistory;
          _setHomeEventHistoryStatus(HomeStatus.success);
        },
      );
    } catch (e) {
      _setHomeSummaryStatus(HomeStatus.error);
      _errorMessage = e.toString();
      notifyListeners();

      print('Event history error: $e');
    }
  }

  void resetState() {
    _homeEventHistory = null;
    _homeSummary = null;
    _errorMessage = null;
    _homeSummaryStatus = HomeStatus.initial;
    notifyListeners();
  }

  void refreshAutoRefresh({
    required String token,
    required int userId,
    Duration interval = const Duration(seconds: 5),
  }) {
    stopAutoRefresh();
    startAutoRefresh(interval: interval, token: token, userId: userId);
  }

  // here
  // start auto refresh setiap interval (default 5 detik)
  void startAutoRefresh({
    Duration interval = const Duration(seconds: 5),
    required String token,
    required int userId,
  }) {
    _autoTimer?.cancel();
    // Fetch pertama segera
    getHomeSummary(token: token, userId: userId);
    getHomeEventHistory(token: token, userId: userId);

    _autoTimer = Timer.periodic(interval, (_) {
      if (_disposed) return;
      getHomeSummary(token: token, userId: userId);
      getHomeEventHistory(token: token, userId: userId);
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
