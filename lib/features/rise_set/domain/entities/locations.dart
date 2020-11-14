import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Locations extends Equatable {
  final double latitide, longitude;

  Locations({@required this.latitide, @required this.longitude});
  @override
  List<Object> get props => [latitide, longitude];
}
