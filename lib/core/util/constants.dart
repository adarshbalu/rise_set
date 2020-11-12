import 'package:flutter/widgets.dart';

const String CACHED_RISE_SET = 'CACHED_RISE_SET';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a double or zero.';

enum Status { LOADED, ERROR, LOADING, EMPTY }

class ColorConstants {
  static const Color DEEP_BLUE = Color(0xff00C0F1);
  static const Color DARK_BLUE = Color(0xff2AD8F6);
  static const Color LIGHT_BLUE = Color(0xffA8EBFA);
  static const Color DARK_YELLOW = Color(0xffFFD400);
  static const Color LIGHT_YELLOW = Color(0xffFFE470);
}

const String LOGO_PNG_LOCATION = 'assets/png/logo.png';
