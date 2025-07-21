import 'package:flutter/material.dart';

class SwitchOption extends StatelessWidget {
  const SwitchOption({
    super.key,
    required this.text,
    required this.isMuted,
    required this.onChanged,
  });

  final String text;
  final bool isMuted;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 16)),
        Switch.adaptive(value: isMuted, onChanged: onChanged),
      ],
    );
  }
}
