import 'package:flutter/material.dart';

void showSnackBar({
  @required GlobalKey<ScaffoldState> scaffoldKey,
  @required String text,
  @required var color,
  Duration duration,
  double height = 30,
}) {
  if (duration == null) duration = Duration(milliseconds: 5000);
  scaffoldKey.currentState.showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 1000,
    content: Container(
      height: height,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    backgroundColor: color,
    duration: duration,
  ));
}