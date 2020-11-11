import 'package:flutter/material.dart';
import 'package:rise_set/core/util/constants.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 100,
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.all(8),
          child: LinearProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.LIGHT_YELLOW),
            backgroundColor: ColorConstants.DARK_YELLOW,
          )),
    );
  }
}
