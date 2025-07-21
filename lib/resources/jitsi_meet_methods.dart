import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:uuid/uuid.dart';

class JitsiMeetMethods {
  /**  We can later set a stronger differences between create and join Meeting 
   * such as options for featureFlags only for mod, search for Meeting ID... 
   * But for now I just make it simple. */

  void createNewMeeting({
    required String roomName,
    required String displayName,
    required String email,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String? imageUrl,
    Map<String, Object?>? featureFlags,
  }) async {
    try {
      // Alternative:
      // final _user = AuthMethods().user;
      final FirebaseMethods firebaseMethods = FirebaseMethods();
      final meetingId = Uuid().v1();
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        userInfo: JitsiMeetUserInfo(
          displayName: displayName,
          email: email,
          avatar: imageUrl,
        ),
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        featureFlags: featureFlags,
      );
      await jitsiMeet.join(options);
      await firebaseMethods.addToMeetingHistory(roomName, meetingId);
    } catch (e) {
      debugPrint('--- Error by creating room: $e ---');
    }
  }

  void joinMeeting({
    required String roomName,
    required String username,
    required String email,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String? imageUrl,
  }) async {
    try {
      // Alternative:
      // final _user = AuthMethods().user;
      final FirebaseMethods firebaseMethods = FirebaseMethods();
      final meetingId = Uuid().v1();
      var jitsiMeet = JitsiMeet();
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        userInfo: JitsiMeetUserInfo(
          displayName: username,
          email: email,
          avatar: imageUrl,
        ),
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
      );
      await jitsiMeet.join(options);
      await firebaseMethods.addToMeetingHistory(roomName, meetingId);
    } catch (e) {
      debugPrint('--- Error by joining room: $e ---');
    }
  }
}
