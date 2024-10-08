import 'package:flutter/material.dart';

class BtnFilled extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const BtnFilled(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Less rounded corners
        ),
      ),
      onPressed: onPressed,
      child: Container(
          width: 150,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          )),
    );
  }
}
