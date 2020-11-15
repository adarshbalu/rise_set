import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Locations extends Equatable {
  final double latitude, longitude;

  Locations({@required this.latitude, @required this.longitude});
  @override
  List<Object> get props => [latitude, longitude];
}
