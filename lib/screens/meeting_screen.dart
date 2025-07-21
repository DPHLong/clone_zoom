import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/models/user_model.dart';
import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:clone_zoom/resources/jitsi_meet_methods.dart';
import 'package:clone_zoom/utils/utils.dart';
import 'package:clone_zoom/widgets/home_meeting_button.dart';
import 'package:flutter/material.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting(String roomName) async {
    final UserModel userModel = await FirebaseMethods().getUserDetails(
      firebaseAuth.currentUser!.uid,
    );

    _jitsiMeetMethods.createNewMeeting(
      roomName: roomName,
      displayName: userModel.username,
      email: userModel.email,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  joinMeeting(String roomName) async {
    final UserModel userModel = await FirebaseMethods().getUserDetails(
      firebaseAuth.currentUser!.uid,
    );

    _jitsiMeetMethods.joinMeeting(
      roomName: roomName,
      username: userModel.username,
      imageUrl: userModel.profileImage,
      email: userModel.email,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String roomName = 'Room ${generateRandomString(6)}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text('Meet & Chat'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                onPressed: () => createNewMeeting(roomName),
                icon: Icons.videocam,
                text: 'New Meeting',
              ),
              HomeMeetingButton(
                onPressed: () => Navigator.of(context).pushNamed('/video-call'),
                icon: Icons.add_box,
                text: 'Join Meeting',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.calendar_month,
                text: 'Schedule',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.arrow_upward,
                text: 'Share Screen',
              ),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Create and Join Meetings with just a click',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
