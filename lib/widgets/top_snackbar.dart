import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
class TopSnackBar {
  fallingTopSnackBar(context, {required Color color,required String text}){
    return showTopSnackBar(Overlay.of(context),
        displayDuration: const Duration(milliseconds: 500),
        CustomSnackBar.info(
          message: text,
          backgroundColor: color,
        )
    );
  }

  successTopSnackBar(context, {required String text}){
    return showTopSnackBar(Overlay.of(context),
        displayDuration: const Duration(milliseconds: 500),
        CustomSnackBar.success(
          message: text,
          // backgroundColor: color,
        )
    );
  }
}