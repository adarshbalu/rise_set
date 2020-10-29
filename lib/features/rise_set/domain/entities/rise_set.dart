import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RiseSet extends Equatable {
  final DateTime sunrise, sunset;

  RiseSet({@required this.sunrise, @required this.sunset});

  @override
  List<Object> get props => [sunrise, sunset];
}
