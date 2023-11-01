import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  normalS(
      {required double fontS,
        required FontWeight fontW,
        required Color color,
        required String fontF,
        required FontStyle fontStl}) {
    return  TextStyle(
        fontSize: fontS.sp,
        fontWeight: fontW ,
        color: color,
        fontFamily: fontF,
        height: 1.2.sp,
        fontStyle: fontStl
    );
  }
  normalSWithUnderline(
      {required double fontS,
        required FontWeight fontW,
        required Color color,
        required String fontF,
        required FontStyle fontStl}) {
    return  TextStyle(
        fontSize: fontS.sp,
        fontWeight: fontW ,
        color: color,
        fontFamily: fontF,
        height: 1.2.sp,
        fontStyle: fontStl,
        decoration: TextDecoration.underline
    );
  }
}
