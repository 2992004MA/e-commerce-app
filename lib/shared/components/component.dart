import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../style/colors.dart';

void navigaiteTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget,),
);

void navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
    (route) => false
);

Widget defaultFormField({
  required TextEditingController controller,
  required String text,
  required IconData prefix,
  required String? Function(String?)? validate,
  required TextInputType type,
  void Function(String)? onChanged,
  void Function(String)? onSubmit,
  void Function()? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
}) => TextFormField(
  controller: controller,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    labelText: text,
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix),
    ),
  ),
  validator: validate,
  keyboardType: type,
  onChanged: onChanged,
  onFieldSubmitted: onSubmit,
  obscureText: isPassword,
);

Widget defaultTextButtom({
  required String text,
  required void Function() onPressed,
}) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: defaultColor,
  ),
  width: double.infinity,
  height: 45,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextBottom2({
  required String text,
  required IconData titleIcon,
  required void Function()? onPressed,
}) => TextButton(
  onPressed: onPressed,
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.grey[200]),
  ),
  child: Row(
    children: [
      Icon(titleIcon , color: defaultColor,),
      SizedBox(width: 10,),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      Icon(
        Icons.arrow_forward_ios,
        color: defaultColor,
      ),
    ],
  ),
);

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates {SUCCESS , ERROR , WARNING}

Color chooseToastColor(ToastStates state){
  Color color;

  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}