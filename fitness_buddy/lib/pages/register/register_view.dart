import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage("assets/images/logo.png")),
        const SizedBox(height: 32),
        Card(
          color: Theme.of(context).primaryColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class BtnFilled extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const BtnFilled({super.key, required this.text, required this.onPressed, required this.backgroundColor, required this.textColor});

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