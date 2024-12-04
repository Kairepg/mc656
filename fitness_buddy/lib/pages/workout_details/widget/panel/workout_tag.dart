import 'package:fitness_buddy/utils/color_constants.dart';
import 'package:flutter/material.dart';

class WorkoutTag extends StatelessWidget {
  final String icon;
  final String content;

  const WorkoutTag({super.key, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.primaryColor.withOpacity(0.12),
      ),
      child: Row(
        children: [
          Image.asset(icon, height: 17, width: 17, fit: BoxFit.fill),
          const SizedBox(width: 7),
          Text(content, style: const TextStyle(color: ColorConstants.primaryColor, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
