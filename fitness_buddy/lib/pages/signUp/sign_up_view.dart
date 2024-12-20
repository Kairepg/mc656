import 'package:flutter/material.dart';
import 'package:fitness_buddy/utils/constants.dart';
import 'package:flutter/gestures.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage(Constants.pathImageLogo), height: 86),
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
    return FormField<bool>(
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  checkColor: Theme.of(context).primaryColor,
                  value: checkValue,
                  onChanged: (bool? newValue) {
                    onChanged(newValue!);
                    state.didChange(newValue);
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
              ],
            ),
            if (state.errorText != null) // Display the error text conditionally
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Indent to align with checkbox
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
      validator: (value) {
        if (checkbox == null) {
          if (!checkValue) {
            return 'Você precisa aceitar os termos e condições';
          } else {
            return null;
          }
        } else {
          if (checkbox?.value == true) {
            return null;
          } else {
            return 'Você precisa aceitar os termos e condições';
          }
        }
      },
    );
  }
}