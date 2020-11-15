import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:rise_set/core/error/failures.dart';
import 'package:rise_set/core/util/constants.dart';
import 'package:rise_set/core/util/input_converter.dart';
import 'package:rise_set/features/rise_set/domain/entities/rise_set.dart';
import 'package:rise_set/features/rise_set/domain/usecases/get_rise_and_set_time.dart';

class RiseSetProvider extends ChangeNotifier with EquatableMixin {
  final GetRiseAndSetTimeFromCustomLocation getRiseAndSetTime;
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
    double validLatitudeValue, validLongitudeValue;
    failureOrLatitude.fold(
      (inputFailure) {
        _riseSet = null;
        _status = Status.ERROR;
        _errorMessage = _mapFailureToMessage(inputFailure);
        notifyListeners();
        return;
      },
      (validLatitude) {
        validLatitudeValue = validLatitude;
      },
    );
    failureOrLongitude.fold((inputFailure) {
      _riseSet = null;
      _status = Status.ERROR;
      _errorMessage = _mapFailureToMessage(inputFailure);
      notifyListeners();
      return;
    }, (validLongitude) async {
      validLongitudeValue = validLongitude;
    });
    if (validLongitudeValue != null && validLatitudeValue != null) {
      final failureOrRiseSet = await getRiseAndSetTime(
          Params(latitude: validLatitudeValue, longitude: validLongitudeValue));

      failureOrRiseSet.fold(
        (failure) {
          _riseSet = null;
          _status = Status.ERROR;
          _errorMessage = _mapFailureToMessage(failure);
          notifyListeners();
          return;
        },
        (riseSet) {
          _riseSet = riseSet;
          _status = Status.LOADED;
          notifyListeners();
        },
      );
    } else {
      _riseSet = null;
      _status = Status.ERROR;

      notifyListeners();

      return;
    }
    notifyListeners();
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
