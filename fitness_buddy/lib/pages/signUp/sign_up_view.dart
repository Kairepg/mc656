import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage("assets/images/logo.png"), height: 86),
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

class LinkedLabelCheckbox extends StatelessWidget {
  const LinkedLabelCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.checkValue,
    required this.onChanged,
    required this.contextRoute,
    required this.route, 
    this.checkbox,
  });

  final String label;
  final EdgeInsets padding;
  final bool checkValue;
  final ValueChanged<bool> onChanged;
  final BuildContext contextRoute;
  final String route;
  final Checkbox? checkbox;

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (state){ return Column(
      // padding: padding,
      children: [Row(
        children: <Widget>[
          Checkbox(
            checkColor: Theme.of(context).primaryColor,
            value: checkValue,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(contextRoute, route);
                  },
              ),
            ),
          ),
          Text(
          state.errorText ?? '',
          style: const TextStyle(
            color: Colors.red,
          ),
        )
        ],
      )],
    );},validator: (value) {
    if (checkbox == null){
      if (!checkValue ) {
        return 'Você precisa aceitar os termos e condições';
      } else {
        return null;
     }
    } else{
      if (checkbox?.value == true){
      return null;
      }else {
        return 'Você precisa aceitar os termos e condições';
      }
    }
  }, );
  }
}
