import 'package:clone_zoom/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeMeetingButton extends StatelessWidget {
  const HomeMeetingButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed.call(),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: secondaryColor, size: 30),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
