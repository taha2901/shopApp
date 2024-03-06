import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultSeparator() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}



Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onFieldSubmitted,
  bool isPassword=false,
  Function()? onTap,
  String? Function(String?)? validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  void Function(String)? onChanged
})=>TextFormField(
  controller:controller ,
  keyboardType:type,
  obscureText: isPassword,
  onFieldSubmitted: onFieldSubmitted,
  
  onTap:onTap,
    onChanged:onChanged,
    validator: validator,
  decoration: InputDecoration(
    labelText:label,
    border: const OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix!= null? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) :null,

  ),
);

