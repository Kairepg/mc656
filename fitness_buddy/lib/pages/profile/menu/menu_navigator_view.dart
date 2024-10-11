import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const CardButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
              ),
            )));
  }
}

// ignore: must_be_immutable
class DisplayCard extends StatelessWidget {
  final Widget text;
  final String subtitle;
  final bool showIcon;
  Widget? icon;

  DisplayCard(
      {super.key,
      required this.text,
      required this.subtitle,
      required this.showIcon,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          //                    <--- top side
          color: Theme.of(context).primaryColor,
          width: 3.0,
        ))),
        child: ListTile(
            title: Text(
              subtitle,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
            ),
            subtitle: text,
            trailing: showIcon ? icon : const Icon(null)),
      ),
    );
  }
}