import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateToAndFinish(context, widget) =>  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (route) => false,
);

enum toastState {succes,error,warning}
Color toastColor (toastState state){
  Color color;
  switch(state){
    case toastState.succes:
      color = Colors.green;
      break;
    case toastState.error:
      color = Colors.red;
      break;
    case toastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast ({
  required String msg,
  required toastState state,
  Toast? Toast = Toast.LENGTH_LONG,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
