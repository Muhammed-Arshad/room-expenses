
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';

class MaterialButtons{
  circularSmallButton({
    required double w,
    required String title,
    required Color color,
    required Color splashColor,
    required Function() onTap,
  }){
    return MaterialButton(
        materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
        onPressed: (){
          onTap();
        },
        minWidth: w.sp,
        height: 22.sp,
        color: color,
        splashColor: splashColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(title,
                style: Styles().normalS(
                    fontS: 9,
                    fontW: FontWeight.w900,
                    color: white,
                    fontF: "Poppins",
                    fontStl: FontStyle.normal),
                textAlign: TextAlign.center
            ),
          ),
        )
    );
  }
  fullWidthBlackButton({
    required double w,
    required String title,
    required Color color,
    required Color splashColor,
    required Function onTap
  }){
    return  Container(
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(
              color: Color(0x1a000000),
              offset: Offset(1,1),
              blurRadius: 15,
              spreadRadius: 0
          )]
      ),
      child: MaterialButton(
          onPressed: (){onTap();},
          minWidth: w,
          height: 50.sp,
          color: color,
          splashColor: splashColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(title,
                style: Styles().normalS(
                    fontS: 14,
                    fontW: FontWeight.w700,
                    color: white,
                    fontF: "Rubik",
                    fontStl: FontStyle.normal),
                textAlign: TextAlign.center
            ),
          )
      ),
    );
  }

  smallButton({
    required double w,
    required double h,
    required String title,
    required Color titleColor,
    required Color color,
    required Color splashColor,
    required Function() onTap,
  }){
    return MaterialButton(
        materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
        onPressed: (){
          onTap();
        },
        minWidth: w.sp,
        height: h.sp,
        color: color,
        splashColor: splashColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Text(title,
            style: Styles().normalS(
                fontS: 12,
                fontW: FontWeight.w700,
                color: titleColor,
                fontF: "Poppins",
                fontStl: FontStyle.normal),
            textAlign: TextAlign.center
        )
    );
  }
}