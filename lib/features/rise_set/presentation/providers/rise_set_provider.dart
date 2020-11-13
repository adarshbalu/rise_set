import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/util/constants.dart';
import 'package:rise_set/core/util/input_converter.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_and_set_time.dart';

class RiseSetProvider extends ChangeNotifier with EquatableMixin {
  final GetRiseAndSetTime getRiseAndSetTime;
  final InputConverter inputConverter;
  Status _status = Status.EMPTY;
  String _errorMessage;
  RiseSet _riseSet;
  RiseSetProvider(this.getRiseAndSetTime, this.inputConverter)
      : assert(getRiseAndSetTime != null),
        assert(inputConverter != null);

  Status get status => _status;
  String get error => _errorMessage;
  RiseSet get riseSet => _riseSet;
  Future<void> getRiseSetTimesFromInput(
      String latitude, String longitude) async {
    _status = Status.LOADING;
    notifyListeners();
    final failureOrLatitude = inputConverter.stringToDouble(latitude);
    final failureOrLongitude = inputConverter.stringToDouble(longitude);

    failureOrLatitude.fold(
      (inputFailure) {
        _riseSet = null;
        _status = Status.ERROR;
        _errorMessage = _mapFailureToMessage(inputFailure);
        notifyListeners();
      },
      (validLatitude) {
        failureOrLongitude.fold((inputFailure) {
          _riseSet = null;
          _status = Status.ERROR;
          _errorMessage = _mapFailureToMessage(inputFailure);
          notifyListeners();
        }, (validLongitude) async {
          final failureOrRiseSet = await getRiseAndSetTime(
              Params(latitude: validLatitude, longitude: validLongitude));
          failureOrRiseSet.fold(
            (failure) {
              _riseSet = null;
              _status = Status.ERROR;
              _errorMessage = _mapFailureToMessage(failure);
              notifyListeners();
            },
            (riseSet) {
              _riseSet = riseSet;
              _status = Status.LOADED;
              notifyListeners();
            },
          );
        });
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InvalidInputFailure:
        return INVALID_INPUT_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  @override
  List<Object> get props => [];
}
