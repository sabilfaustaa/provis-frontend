import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';
import 'package:intl/date_symbols.dart';

Widget buildBackground(BoxDecoration boxDecoration) {
  return Container(
    decoration: boxDecoration,
  );
}

Widget buildTextField({
  TextEditingController? controller,
  required String hint,
  required bool obscureText,
  IconData? prefixIcon,
  Color backgroundColor = Colors.white,
  Color iconColor = Colors.black,
  double fieldHeight = 48.0,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    maxLines: maxLines,
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: backgroundColor,
      filled: true,
      prefixIcon: prefixIcon != null
          ? IconTheme(
              data: IconThemeData(
                color: iconColor,
              ),
              child: Icon(prefixIcon),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: (fieldHeight - 24.0) / 2,
        horizontal: 12,
      ),
    ),
  );
}

Widget buildButton(BuildContext context, String title, VoidCallback onPressed,
    Color bgColor, Color txtColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
    width: MediaQuery.of(context).size.width * 0.85,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Colors.orange),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: txtColor),
      ),
    ),
  );
}
