import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/utils/utils.dart';
import 'package:flutter/material.dart';

// Just a simple design
class MeetingListTile extends StatelessWidget {
  const MeetingListTile({
    super.key,
    required this.meetingId,
    required this.meetingName,
    required this.createdAt,
  });

  final String meetingId;
  final String meetingName;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        meetingName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
      ),
      subtitle: Text(
        'Joined on ${formatedDate(createdAt)}',
        style: TextStyle(color: secondaryColor),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.call, color: Colors.green),
      ),
    );
  }
}
