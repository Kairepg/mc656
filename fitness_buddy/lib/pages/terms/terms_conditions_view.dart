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


// class LinkedLabelCheckbox extends StatelessWidget {
//   const LinkedLabelCheckbox({
//     super.key,
//     required this.label,
//     required this.padding,
//     required this.value,
//     required this.onChanged,
//   });

//   final String label;
//   final EdgeInsets padding;
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 text: label,
//                 style: const TextStyle(
//                   color: Colors.blueAccent,
//                   decoration: TextDecoration.underline,
//                 ),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     debugPrint('Label has been tapped.');
//                   },
//               ),
//             ),
//           ),
//           Checkbox(
//             value: value,
//             onChanged: (bool? newValue) {
//               onChanged(newValue!);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }