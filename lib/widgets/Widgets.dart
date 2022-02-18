import 'package:firebaseapp/widgets/Sizeconfig.dart';
import 'package:flutter/material.dart';

class Widgets {
  static Padding padding(
      {required child,
      double top = 0,
      double left = 0,
      double right = 0,
      double bottom = 0}) {
    return Padding(
      padding: EdgeInsets.only(
        top: getH(top),
        left: getW(left),
        right: getW(right),
        bottom: getH(bottom),
      ),
      child: child,
    );
  }
}
