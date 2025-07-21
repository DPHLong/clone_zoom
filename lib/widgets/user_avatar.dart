import 'package:clone_zoom/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.radius,
    this.imageUrl,
    this.image,
  });

  const UserAvatar.network({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.image,
  });

  final String? imageUrl;
  final double radius;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return imageUrl?.isEmpty ?? true
        ? CircleAvatar(
            radius: radius,
            backgroundColor: primaryColor,
            backgroundImage: image != null ? MemoryImage(image!) : null,
            child: image != null ? null : Icon(Icons.person, size: radius),
          )
        : Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Image.network(imageUrl!, fit: BoxFit.cover),
          );
  }
}
