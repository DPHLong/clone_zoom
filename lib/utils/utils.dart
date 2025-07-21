import 'dart:math';

import 'package:clone_zoom/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content, style: TextStyle(color: primaryColor)),
      backgroundColor: greyColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

String formatedDate(DateTime date) {
  final outputDateFormat = DateFormat("dd/MM/yyyy HH:mm").format(date);
  return outputDateFormat;
}

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return await image.readAsBytes();
    } else {
      debugPrint('--- No image selected ---');
      return null;
    }
  } catch (e) {
    debugPrint('--- Error picking image: $e ---');
    return null;
  }
}

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}
