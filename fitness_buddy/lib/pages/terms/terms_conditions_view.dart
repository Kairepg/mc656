import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage("assets/logo_images/logo.png"), height: 86),
        const SizedBox(height: 32),
        Card(
          color: Theme.of(context).primaryColor,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
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


